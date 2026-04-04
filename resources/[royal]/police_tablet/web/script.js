const body = document.body;
const lockscreen = document.getElementById("lockscreen");
const loading = document.getElementById("loading");
const content = document.getElementById("content");

const lockTime = document.getElementById("lockTime");
const lockDate = document.getElementById("lockDate");
const lockWeekday = document.getElementById("lockWeekday");
const topbarTime = document.getElementById("topbarTime");
const loadingTitle = document.getElementById("loadingTitle");
const loadingSubtitle = document.getElementById("loadingSubtitle");

const policeBadge = document.getElementById("policeBadge");
const policeName = document.getElementById("policeName");
const userName = document.getElementById("userName");
const userRole = document.getElementById("userRole");
const userAvatar = document.getElementById("userAvatar");

const tabs = document.querySelectorAll(".tab");
const navButtons = document.querySelectorAll(".nav-btn");

const state = {
    dashboard: null,
    members: [],
    bank: null,
    occurrences: [],
    boletins: [],
    procurados: [],
    wantedTarget: null,
    articles: [],
    currentArticleId: null,
    currentBoletimId: null,
    selectedPrisonArticles: []
};

window.addEventListener("message", function(event) {
    const data = event.data || {};

    if (data.action === "open") {
        body.style.display = "block";
        lockscreen.style.display = "block";
        loading.style.display = "none";
        content.style.display = "none";

        if (data.payload) {
            loadingTitle.textContent = data.payload.loadingText || "Abrindo terminal policial";
            loadingSubtitle.textContent = data.payload.loadingSubText || "Sincronizando dados operacionais...";
        }

        switchTab("dashboard");
        return;
    }

    if (data.action === "close") {
        body.style.display = "none";
        lockscreen.style.display = "none";
        loading.style.display = "none";
        content.style.display = "none";
        return;
    }

    if (data.action === "unlock") {
        lockscreen.style.display = "none";
        loading.style.display = "block";
        content.style.display = "none";

        setTimeout(() => {
            loading.style.display = "none";
            content.style.display = "block";
        }, 1400);
        return;
    }

    if (data.action === "setTime") {
        const time = `${data.hour}:${data.minute}`;
        lockTime.textContent = time;
        lockDate.textContent = `${data.day}/${data.month}/${data.year}`;
        lockWeekday.textContent = data.weekday || "";
        topbarTime.textContent = time;
        return;
    }

    if (data.action === "payload" && data.payload) {
        handlePayload(data.payload.action, data.payload.data);
    }
});

navButtons.forEach((button) => {
    button.addEventListener("click", () => switchTab(button.dataset.tab));
});

function switchTab(tabName) {
    navButtons.forEach((btn) => btn.classList.toggle("active", btn.dataset.tab === tabName));
    tabs.forEach((tab) => tab.classList.toggle("active", tab.id === `tab-${tabName}`));
}

function getArticlePermissions() {
    return state.dashboard?.player?.articlePermissions || { create: false, edit: false, delete: false };
}

function canCreateArticle() {
    return !!getArticlePermissions().create;
}

function canEditArticle() {
    return !!getArticlePermissions().edit;
}

function canDeleteArticle() {
    return !!getArticlePermissions().delete;
}

function getBoletimPermissions() {
    return state.dashboard?.player?.boletimPermissions || { create: false, edit: false, delete: false };
}

function canCreateBoletim() {
    return !!getBoletimPermissions().create;
}

function canEditBoletim() {
    return !!getBoletimPermissions().edit;
}

function canDeleteBoletim() {
    return !!getBoletimPermissions().delete;
}

function getProcuradoPermissions() {
    return state.dashboard?.player?.procuradoPermissions || { create: false, delete: false };
}

function canCreateProcurado() {
    return !!getProcuradoPermissions().create;
}

function canDeleteProcurado() {
    return !!getProcuradoPermissions().delete;
}

function handlePayload(action, data) {
    if (action === "bootstrap") {
        state.dashboard = data.dashboard || null;
        state.members = data.members || [];
        state.bank = data.bank || { balance: 0, history: [] };
        state.occurrences = data.occurrences || [];
        state.boletins = data.boletins || [];
        state.procurados = data.procurados || [];
        state.articles = data.articles || [];
        renderAll();
        return;
    }

    if (action === "dashboard") {
        state.dashboard = data || null;
        renderDashboard();
        return;
    }

    if (action === "members") {
        state.members = data || [];
        renderMembers();
        return;
    }

    if (action === "bank") {
        state.bank = data || { balance: 0, history: [] };
        renderBank();
        return;
    }

    if (action === "occurrences") {
        state.occurrences = data || [];
        renderOccurrences();
        return;
    }

    if (action === "boletins") {
        state.boletins = data || [];
        renderBoletins();
        return;
    }

    if (action === "procurados") {
        state.procurados = data || [];
        renderProcurados();
        updateProcuradoFormState();
        return;
    }

    if (action === "wantedTarget") {
        state.wantedTarget = data || null;
        fillProcuradoTarget(data);
        return;
    }

    if (action === "articles") {
        state.articles = data || [];
        renderArticles();
        renderPrisonArticleSelector();
        updatePrisonTotals();
        updateArticleFormState();
        return;
    }

    if (action === "consultPerson") {
        renderPersonResult(data);
        return;
    }

    if (action === "consultVehicle") {
        renderVehicleResult(data);
    }
}

function renderAll() {
    renderDashboard();
    renderMembers();
    renderBank();
    renderOccurrences();
    renderBoletins();
    renderProcurados();
    renderArticles();
    updateProcuradoFormState();
    renderPrisonArticleSelector();
    updatePrisonTotals();
    updateArticleFormState();
}

function renderDashboard() {
    if (!state.dashboard) return;

    policeBadge.textContent = state.dashboard.police?.short || "POL";
    policeName.textContent = state.dashboard.police?.label || "Corporação";
    policeBadge.style.background = `${hexToRgba(state.dashboard.police?.color || "#2f6dff", 0.18)}`;
    policeBadge.style.borderColor = `${hexToRgba(state.dashboard.police?.color || "#2f6dff", 0.35)}`;
    userName.textContent = `${state.dashboard.player?.name || "Sem nome"} #${state.dashboard.player?.passport || 0}`;
    userRole.textContent = `${state.dashboard.player?.role || "Sem cargo"} • Hierarquia ${state.dashboard.player?.hierarchy || 0}`;
    userAvatar.textContent = state.dashboard.police?.short || "PD";

    const bankBalanceEl = document.getElementById("bankBalance");
    const patrolCountEl = document.getElementById("patrolCount");
    const onlineCountEl = document.getElementById("onlineCount");

    if (bankBalanceEl) bankBalanceEl.textContent = formatMoney(state.dashboard.bankBalance || 0);
    if (patrolCountEl) patrolCountEl.textContent = state.dashboard.patrolCount || 0;
    if (onlineCountEl) onlineCountEl.textContent = state.dashboard.onlineCount || 0;

    const notices = document.getElementById("noticesList");
    if (notices) {
        notices.innerHTML = "";
        const noticeList = state.dashboard.notices || [];

        if (!noticeList.length) {
            notices.innerHTML = '<div class="notice-item"><div class="notice-item-text">Nenhum aviso cadastrado.</div></div>';
        } else {
            noticeList.forEach((item) => {
                notices.innerHTML += `
                    <div class="notice-item">
                        <div class="notice-item-title">${escapeHtml(item.title)}</div>
                        <div class="notice-item-meta">${escapeHtml(item.author_name || "Sistema")} • ${formatDate(item.created_at)}</div>
                        <div class="notice-item-text">${escapeHtml(item.content || "")}</div>
                    </div>
                `;
            });
        }
    }

    const patrolList = document.getElementById("patrolList");
    if (patrolList) {
        patrolList.innerHTML = "";
        const patrolRows = state.dashboard.patrol || [];

        if (!patrolRows.length) {
            patrolList.innerHTML = '<div class="row-item"><div class="row-main">Nenhum policial online.</div></div>';
        } else {
            patrolRows.forEach((item) => {
                patrolList.innerHTML += `
                    <div class="row-item">
                        <div class="row-main">${escapeHtml(item.name)} #${item.passport}
                            <span class="badge ${item.patrol ? "success" : "warning"}">${item.patrol ? "Em patrulha" : "Sem serviço"}</span>
                        </div>
                        <div class="row-sub">${escapeHtml(item.role)} • Hierarquia ${item.hierarchy}</div>
                    </div>
                `;
            });
        }
    }
}

function renderMembers() {
    const wrapper = document.getElementById("membersTable");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.members.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhum membro sincronizado.</div><div class="row-sub">Use o evento police_tablet:syncMember para manter a lista completa.</div></div>';
        return;
    }

    state.members.forEach((member) => {
        wrapper.innerHTML += `
            <div class="row-item member-row-item">
                <div class="member-row-top">
                    <div class="row-main member-row-main">${escapeHtml(member.name)} #${member.passport}
                        <span class="badge ${member.online ? "success" : "danger"}">${member.online ? "Online" : "Offline"}</span>
                    </div>
                    <div class="member-row-actions">
                        <button class="success-btn mini-member-btn" onclick="promoteMember(${Number(member.passport) || 0})">Promover</button>
                        <button class="danger-btn mini-member-btn" onclick="demoteMember(${Number(member.passport) || 0})">Rebaixar</button>
                    </div>
                </div>
                <div class="row-sub">${escapeHtml(member.role || "Sem cargo")} • Hierarquia ${member.hierarchy || "-"} • Último acesso ${formatDate(member.last_seen)}</div>
            </div>
        `;
    });
}

function renderBank() {
    const historyEl = document.getElementById("bankHistory");
    const balanceEl = document.getElementById("bankBalance");
    const balanceBoxEl = document.getElementById("bankBalanceBox");

    if (!state.bank) {
        const zeroText = formatMoney(0);

        if (balanceEl) balanceEl.textContent = zeroText;
        if (balanceBoxEl) balanceBoxEl.textContent = zeroText;

        if (historyEl) {
            historyEl.innerHTML = `
                <div class="row-item">
                    <div class="row-main">Nenhuma movimentação registrada.</div>
                </div>
            `;
        }
        return;
    }

    const formattedBalance = formatMoney(state.bank.balance || 0);

    if (balanceEl) balanceEl.textContent = formattedBalance;
    if (balanceBoxEl) balanceBoxEl.textContent = formattedBalance;

    if (!historyEl) return;

    const history = Array.isArray(state.bank.history) ? state.bank.history : [];
    historyEl.innerHTML = "";

    if (!history.length) {
        historyEl.innerHTML = `
            <div class="row-item">
                <div class="row-main">Nenhuma movimentação registrada.</div>
            </div>
        `;
        return;
    }

    historyEl.innerHTML = history.map((item) => {
        const kind = String(item.type || "").toLowerCase();
        const isDeposit = kind === "deposit";
        const isTransfer = kind === "transfer";
        const label = isDeposit ? "Depósito" : (isTransfer ? "Transferência" : "Saque");
        const badgeClass = isDeposit ? "success" : (isTransfer ? "warning" : "danger");
        const badgeText = isDeposit ? "DEPÓSITO" : (isTransfer ? "TRANSFERÊNCIA" : "SAQUE");

        return `
            <div class="row-item">
                <div class="row-main">
                    ${label} • ${formatMoney(item.amount)}
                    <span class="badge ${badgeClass}">${badgeText}</span>
                </div>
                <div class="row-sub">
                    ${escapeHtml(item.description || "Sem descrição")} •
                    ${escapeHtml(item.actor_name || "Sistema")} #${item.actor_passport || 0} •
                    ${formatDate(item.created_at)}
                </div>
            </div>
        `;
    }).join("");
}

function renderOccurrences() {
    const wrapper = document.getElementById("occurrencesTable");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.occurrences.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhuma ocorrência cadastrada.</div></div>';
        return;
    }

    state.occurrences.forEach((item) => {
        wrapper.innerHTML += `
            <div class="row-item">
                <div class="row-main">${escapeHtml(item.title)}
                    <span class="badge warning">${escapeHtml(item.status || "Status")}</span>
                </div>
                <div class="row-sub">Suspeito: ${escapeHtml(item.suspect_name || "Não informado")} • Oficial: ${escapeHtml(item.officer_name || "Não informado")} • ${formatDate(item.created_at)}</div>
            </div>
        `;
    });
}

function renderBoletins() {
    const wrapper = document.getElementById("boletinsTable");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.boletins.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhum boletim cadastrado.</div></div>';
        return;
    }

    state.boletins.forEach((item) => {
        wrapper.innerHTML += `
            <div class="row-item article-row">
                <div class="article-row-top">
                    <div>
                        <div class="row-main">${escapeHtml(item.title || "Boletim")}</div>
                        <div class="row-sub">Envolvidos: ${escapeHtml(item.involved || "Não informado")} • Oficiais: ${escapeHtml(item.officers_involved || "Não informado")} • Registrado por: ${escapeHtml(item.officer_name || "Não informado")} • ${formatDate(item.created_at)}</div>
                    </div>
                    <div class="article-actions">
                        ${canEditBoletim() ? `<button class="secondary-btn article-action-btn" onclick="editBoletim(${Number(item.id || 0)})">Editar</button>` : ""}
                        ${canDeleteBoletim() ? `<button class="danger-btn article-action-btn" onclick="deleteBoletim(${Number(item.id || 0)})">Excluir</button>` : ""}
                    </div>
                </div>
                <div class="article-description">${escapeHtml(item.description || "---")}</div>
            </div>
        `;
    });
}

function renderProcurados() {
    const wrapper = document.getElementById("procuradosTable");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.procurados.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhum procurado cadastrado.</div></div>';
        return;
    }

    state.procurados.forEach((item) => {
        const danger = Number(item.danger_level || 1);
        const photo = item.photo_url ? `<img src="${escapeAttribute(item.photo_url)}" class="wanted-photo" alt="Foto do procurado">` : '<div class="wanted-photo wanted-photo-placeholder">Sem foto</div>';;
        wrapper.innerHTML += `
            <div class="wanted-card">
                ${photo}
                <div class="wanted-info">
                    <div class="wanted-header">
                        <div>
                            <div class="row-main">${escapeHtml(item.suspect_name || "---")} #${Number(item.suspect_passport || 0)}</div>
                            <div class="row-sub">Idade: ${escapeHtml(item.suspect_age || "---")} • Sexo: ${escapeHtml(item.suspect_sex || "---")} • Telefone: ${escapeHtml(item.suspect_phone || "---")}</div>
                        </div>
                        <div class="article-actions">
                            <span class="badge danger-level-${danger}">Periculosidade ${danger}</span>
                            ${canDeleteProcurado() ? `<button class="danger-btn article-action-btn" onclick="deleteProcurado(${Number(item.id || 0)})">Excluir</button>` : ""}
                        </div>
                    </div>
                    <div class="article-description"><strong>Motivo:</strong> ${escapeHtml(item.reason || "---")}</div>
                    <div class="row-sub">Cadastrado por: ${escapeHtml(item.officer_name || "---")} • ${formatDate(item.created_at)}</div>
                </div>
            </div>
        `;
    });
}

function updateProcuradoFormState() {
    const fields = ["wantedPassport", "wantedName", "wantedAge", "wantedSex", "wantedPhone", "wantedDanger", "wantedReason", "wantedPhotoInput", "wantedPhotoUrl"];
    const btn = document.getElementById("wantedSubmitBtn");
    const allowed = canCreateProcurado();
    fields.forEach((id) => {
        const el = document.getElementById(id);
        if (!el) return;
        const keepEnabled = id === "wantedPassport" || id === "wantedPhotoInput" || id === "wantedPhotoUrl" || id === "wantedDanger" || id === "wantedReason";
        if (!keepEnabled) el.disabled = true;
        else el.disabled = !allowed;
    });
    if (btn) btn.style.display = allowed ? "inline-flex" : "none";
}

function fillProcuradoTarget(result) {
    const found = result && result.found;
    const name = document.getElementById("wantedName");
    const age = document.getElementById("wantedAge");
    const sex = document.getElementById("wantedSex");
    const phone = document.getElementById("wantedPhone");
    if (name) name.value = found ? (result.name || "") : "";
    if (age) age.value = found ? (result.age || "---") : "";
    if (sex) sex.value = found ? (result.sex || "---") : "";
    if (phone) phone.value = found ? (result.phone || "---") : "";
    if (!found) notify("amarelo", "Passaporte não encontrado para preencher o procurado.");
}

function handleWantedPhotoInput(event) {
    const file = event?.target?.files?.[0];
    if (!file) return;
    if (file.size > 1024 * 1024) {
        notify("amarelo", "A foto está muito pesada. Use uma imagem de até 1MB.");
        if (event?.target) event.target.value = "";
        return;
    }
    const reader = new FileReader();
    reader.onload = function(e) {
        const value = e.target?.result || "";
        if (String(value).length > 800000) {
            notify("amarelo", "A foto ficou muito grande. Use uma imagem menor.");
            const preview = document.getElementById("wantedPhotoPreview");
            const urlField = document.getElementById("wantedPhotoUrl");
            if (urlField) urlField.value = "";
            if (preview) preview.innerHTML = "Sem foto";
            return;
        }
        const urlField = document.getElementById("wantedPhotoUrl");
        const preview = document.getElementById("wantedPhotoPreview");
        if (urlField) urlField.value = value;
        if (preview) {
            preview.innerHTML = value ? `<img src="${escapeAttribute(value)}" class="wanted-preview-image" alt="Prévia da foto">` : 'Sem foto';
        }
    };
    reader.readAsDataURL(file);
}

function fetchWantedTarget() {
    if (!canCreateProcurado()) return;
    const passport = Number(document.getElementById("wantedPassport")?.value || 0);
    if (passport <= 0) {
        fillProcuradoTarget({ found: false });
        return;
    }
    request("consultWantedTarget", { passport });
}

function createProcurado() {
    if (!canCreateProcurado()) return;
    const passport = Number(document.getElementById("wantedPassport")?.value || 0);
    const danger = Number(document.getElementById("wantedDanger")?.value || 0);
    const reason = document.getElementById("wantedReason")?.value || "";
    const photoUrl = document.getElementById("wantedPhotoUrl")?.value || "";
    if (String(photoUrl).length > 800000) {
        notify("amarelo", "A foto está muito grande. Use uma imagem menor.");
        return;
    }
    if (passport <= 0) {
        notify("amarelo", "Informe o passaporte do procurado.");
        return;
    }
    if (danger < 1 || danger > 3) {
        notify("amarelo", "Selecione o grau de periculosidade de 1 a 3.");
        return;
    }
    request("createProcurado", {
        passport,
        danger_level: danger,
        reason,
        photo_url: photoUrl
    });
    clearProcuradoForm();
}

function clearProcuradoForm() {
    ["wantedPassport","wantedName","wantedAge","wantedSex","wantedPhone","wantedReason","wantedPhotoUrl"].forEach((id) => {
        const el = document.getElementById(id);
        if (el) el.value = "";
    });
    const danger = document.getElementById("wantedDanger");
    if (danger) danger.value = "1";
    const input = document.getElementById("wantedPhotoInput");
    if (input) input.value = "";
    const preview = document.getElementById("wantedPhotoPreview");
    if (preview) preview.innerHTML = "Sem foto";
    state.wantedTarget = null;
}

function deleteProcurado(procuradoId) {
    if (!canDeleteProcurado()) return;
    procuradoId = Number(procuradoId || 0);
    if (!procuradoId) return;
    request("deleteProcurado", { procurado_id: procuradoId });
}

function renderPrisonArticleSelector() {
    const wrapper = document.getElementById("prisonArticlesList");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.articles.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhum artigo cadastrado.</div></div>';
        return;
    }

    wrapper.innerHTML = state.articles.map((item) => {
        const checked = state.selectedPrisonArticles.includes(Number(item.id)) ? "checked" : "";
        return `
            <label class="prison-article-item">
                <input type="checkbox" value="${Number(item.id || 0)}" ${checked} onchange="togglePrisonArticle(${Number(item.id || 0)})">
                <div>
                    <div class="row-main">Art. ${escapeHtml(item.code)} - ${escapeHtml(item.title)}</div>
                    <div class="row-sub">Prisão: ${Number(item.jail_time || 0)} meses • Multa: ${formatMoney(item.fine_value || 0)}</div>
                </div>
            </label>
        `;
    }).join("");
}

function togglePrisonArticle(articleId) {
    articleId = Number(articleId || 0);
    if (!articleId) return;

    if (state.selectedPrisonArticles.includes(articleId)) {
        state.selectedPrisonArticles = state.selectedPrisonArticles.filter((id) => id !== articleId);
    } else {
        state.selectedPrisonArticles.push(articleId);
    }

    updatePrisonTotals();
    renderPrisonArticleSelector();
}

function updatePrisonTotals() {
    let totalPrison = 0;
    let totalFine = 0;

    (state.articles || []).forEach((item) => {
        if (state.selectedPrisonArticles.includes(Number(item.id))) {
            totalPrison += Number(item.jail_time || 0);
            totalFine += Number(item.fine_value || 0);
        }
    });

    totalPrison += Number(document.getElementById("additionalPrison")?.value || 0);
    totalFine += Number(document.getElementById("additionalFine")?.value || 0);

    const totalPrisonField = document.getElementById("totalPrison");
    const totalFineField = document.getElementById("totalFine");
    if (totalPrisonField) totalPrisonField.value = totalPrison;
    if (totalFineField) totalFineField.value = formatMoney(totalFine);
}

function renderArticles() {
    const wrapper = document.getElementById("articlesTable");
    if (!wrapper) return;

    wrapper.innerHTML = "";

    if (!state.articles.length) {
        wrapper.innerHTML = '<div class="row-item"><div class="row-main">Nenhum artigo cadastrado.</div></div>';
        return;
    }

    state.articles.forEach((item) => {
        wrapper.innerHTML += `
            <div class="row-item article-row">
                <div class="article-row-top">
                    <div>
                        <div class="row-main">Art. ${escapeHtml(item.code)} - ${escapeHtml(item.title)}</div>
                        <div class="row-sub">Multa: ${formatMoney(item.fine_value || 0)} • Prisão: ${item.jail_time || 0} meses</div>
                    </div>
                    <div class="article-actions">
                        ${canEditArticle() ? `<button class="secondary-btn article-action-btn" onclick="editArticle(${Number(item.id || 0)})">Editar</button>` : ""}
                        ${canDeleteArticle() ? `<button class="danger-btn article-action-btn" onclick="deleteArticle(${Number(item.id || 0)})">Excluir</button>` : ""}
                    </div>
                </div>
                <div class="article-description">${escapeHtml(item.description || "Sem descrição.")}</div>
            </div>
        `;
    });
}

function buildPrisonHistoryHtml(result) {
    const prisonHistory = (result.prisonHistory || []).map((item) => `
        <div class="history-row">
            <strong>${formatDate(item.created_at)}</strong><br>
            Oficial: ${escapeHtml(item.officer_name || "---")}<br>
            Artigos: ${escapeHtml(item.article_codes || "---")}<br>
            Pena: ${Number(item.total_prison || 0)} meses • Multa: ${formatMoney(item.total_fine || 0)}
        </div>
    `).join("") || "Nenhum registro.";

    const seizureHistory = (result.seizureHistory || []).map((item) => `
        <div class="history-row">
            <strong>${formatDate(item.created_at)}</strong><br>
            Oficial: ${escapeHtml(item.officer_name || "---")}<br>
            Item: ${escapeHtml(item.item_name || "---")} • Qtd: ${Number(item.item_amount || 0)}
        </div>
    `).join("") || "Nenhum registro.";

    return `
        <hr>
        <strong>Serviços de prisão:</strong> ${Number(result.prison || 0)}<br>
        <strong>Histórico de prisão</strong><br>${prisonHistory}
        <hr>
        <strong>Histórico de apreensão</strong><br>${seizureHistory}
    `;
}

function renderPrisonResult(result) {
    const wrapper = document.getElementById("prisonResult");
    if (!wrapper) return;

    if (!result || !result.found) {
        wrapper.className = "details-box empty-state";
        wrapper.innerHTML = "Passaporte não encontrado.";
        return;
    }

    wrapper.className = "details-box";
    wrapper.innerHTML = buildPrisonHistoryHtml(result);
}

function renderPersonResult(result) {
    const wrapper = document.getElementById("personResult");
    if (!wrapper) return;

    if (!result || !result.found) {
        wrapper.className = "details-box empty-state";
        wrapper.innerHTML = "Passaporte não encontrado.";
        return;
    }

    const vehicles = (result.vehicles || []).map((vehicle) => `${escapeHtml(vehicle.model)} (${escapeHtml(vehicle.plate)})`).join("<br>") || "Nenhum";
    const groups = Object.keys(result.groups || {}).join(", ") || "Nenhum";

    wrapper.className = "details-box";
    wrapper.innerHTML = `
        <strong>Nome:</strong> ${escapeHtml(result.name)}<br>
        <strong>Passaporte:</strong> ${result.passport}<br>
        <strong>Telefone:</strong> ${escapeHtml(result.phone)}<br>
        <strong>Idade:</strong> ${escapeHtml(result.age || "---")}<br>
        <strong>Sexo:</strong> ${escapeHtml(result.sex)}<br>
        <strong>Banco:</strong> ${escapeHtml(result.bank)}<br>
        <strong>Multas acumuladas:</strong> ${formatMoney(result.fines || 0)}<br>
        <strong>Grupos:</strong> ${escapeHtml(groups)}<br>
        <strong>Veículos:</strong><br>${vehicles}
        ${buildPrisonHistoryHtml(result)}
    `;

    const prisonPassport = document.getElementById("prisonPassport");
    if (prisonPassport) prisonPassport.value = result.passport || "";
}

function renderVehicleResult(result) {
    const wrapper = document.getElementById("vehicleResult");
    if (!wrapper) return;

    if (!result || !result.found) {
        wrapper.className = "details-box empty-state";
        wrapper.innerHTML = "Veículo não encontrado.";
        return;
    }

    wrapper.className = "details-box";
    wrapper.innerHTML = `
        <strong>Modelo:</strong> ${escapeHtml(result.model)}<br>
        <strong>Placa:</strong> ${escapeHtml(result.plate)}<br>
        <strong>Proprietário:</strong> ${escapeHtml(result.ownerName)}<br>
        <strong>Passaporte do proprietário:</strong> ${result.ownerPassport}
    `;
}

function request(action, payload = {}) {
    fetch(`https://${GetParentResourceName()}/request`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action, payload })
    });
}

function notify(color, message) {
    fetch(`https://${GetParentResourceName()}/notify`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ color, message })
    });
}

function requestRefresh() {
    request("refreshAll");
}

function hireMember() {
    request("hireMember", {
        passport: Number(document.getElementById("memberPassport")?.value || 0)
    });
}

function promoteMember(passport) {
    const targetPassport = Number(passport || document.getElementById("memberPassport")?.value || 0);
    request("promoteMember", {
        passport: targetPassport
    });
}

function demoteMember(passport) {
    const targetPassport = Number(passport || document.getElementById("memberPassport")?.value || 0);
    request("demoteMember", {
        passport: targetPassport
    });
}

function fireMember() {
    request("fireMember", {
        passport: Number(document.getElementById("memberPassport")?.value || 0)
    });
}

function transferBank() {
    request("transferBank", {
        passport: Number(document.getElementById("bankTransferPassport")?.value || 0),
        amount: Number(document.getElementById("bankAmount")?.value || 0),
        description: document.getElementById("bankDescription")?.value || ""
    });
}

function createNotice() {
    request("createNotice", {
        title: document.getElementById("noticeTitle")?.value || "",
        content: document.getElementById("noticeContent")?.value || ""
    });

    if (document.getElementById("noticeTitle")) document.getElementById("noticeTitle").value = "";
    if (document.getElementById("noticeContent")) document.getElementById("noticeContent").value = "";
}

function depositBank() {
    request("deposit", {
        amount: Number(document.getElementById("bankAmount")?.value || 0),
        description: document.getElementById("bankDescription")?.value || ""
    });
}

function withdrawBank() {
    request("withdraw", {
        amount: Number(document.getElementById("bankAmount")?.value || 0),
        description: document.getElementById("bankDescription")?.value || ""
    });
}

function createOccurrence() {
    request("createOccurrence", {
        title: document.getElementById("occTitle")?.value || "",
        suspect_name: document.getElementById("occSuspectName")?.value || "",
        suspect_passport: Number(document.getElementById("occSuspectPassport")?.value || 0),
        status: document.getElementById("occStatus")?.value || "",
        description: document.getElementById("occDescription")?.value || ""
    });
}

function updateBoletimFormState() {
    const submit = document.getElementById("boletimSubmitBtn");
    const cancel = document.getElementById("boletimCancelBtn");
    const fields = ["boletimTitle", "boletimInvolved", "boletimOfficers", "boletimDescription"];
    const permissions = getBoletimPermissions();
    const isEditing = !!state.currentBoletimId;
    const canSubmit = isEditing ? !!permissions.edit : !!permissions.create;

    if (submit) {
        submit.textContent = isEditing ? "Salvar boletim" : "Cadastrar boletim";
        submit.style.display = canSubmit ? "inline-flex" : "none";
    }

    if (cancel) cancel.style.display = isEditing && permissions.edit ? "inline-flex" : "none";

    fields.forEach((fieldId) => {
        const field = document.getElementById(fieldId);
        if (field) field.disabled = !canSubmit;
    });
}

function clearBoletimForm() {
    const fields = ["boletimTitle", "boletimInvolved", "boletimOfficers", "boletimDescription"];
    fields.forEach((id) => {
        const el = document.getElementById(id);
        if (el) el.value = "";
    });

    state.currentBoletimId = null;

    const submit = document.getElementById("boletimSubmitBtn");
    const cancel = document.getElementById("boletimCancelBtn");
    if (submit) submit.textContent = "Cadastrar boletim";
    if (cancel) cancel.style.display = "none";
    updateBoletimFormState();
}

function createBoletim() {
    const permissions = getBoletimPermissions();
    const isEditing = !!state.currentBoletimId;
    if (isEditing && !permissions.edit) return;
    if (!isEditing && !permissions.create) return;

    const payload = {
        title: document.getElementById("boletimTitle")?.value || "",
        involved: document.getElementById("boletimInvolved")?.value || "",
        officers_involved: document.getElementById("boletimOfficers")?.value || "",
        description: document.getElementById("boletimDescription")?.value || ""
    };

    if (state.currentBoletimId) {
        payload.boletim_id = state.currentBoletimId;
        request("updateBoletim", payload);
    } else {
        request("createBoletim", payload);
    }

    clearBoletimForm();
}

function editBoletim(boletimId) {
    if (!canEditBoletim()) return;
    boletimId = Number(boletimId || 0);
    const item = (state.boletins || []).find((entry) => Number(entry.id) === boletimId);
    if (!item) return;

    state.currentBoletimId = boletimId;

    const title = document.getElementById("boletimTitle");
    const involved = document.getElementById("boletimInvolved");
    const officers = document.getElementById("boletimOfficers");
    const description = document.getElementById("boletimDescription");
    const submit = document.getElementById("boletimSubmitBtn");
    const cancel = document.getElementById("boletimCancelBtn");

    if (title) title.value = item.title || "";
    if (involved) involved.value = item.involved || "";
    if (officers) officers.value = item.officers_involved || "";
    if (description) description.value = item.description || "";
    if (submit) submit.textContent = "Salvar boletim";
    if (cancel) cancel.style.display = "block";

    title?.scrollIntoView({ behavior: "smooth", block: "center" });
}

function cancelBoletimEdit() {
    clearBoletimForm();
}

function deleteBoletim(boletimId) {
    if (!canDeleteBoletim()) return;
    boletimId = Number(boletimId || 0);
    if (!boletimId) return;
    request("deleteBoletim", { boletim_id: boletimId });
    if (state.currentBoletimId === boletimId) {
        clearBoletimForm();
    }
}

function consultPerson() {
    const passport = Number(document.getElementById("personPassport")?.value || 0);
    const prisonPassport = document.getElementById("prisonPassport");
    if (prisonPassport) prisonPassport.value = passport || "";
    request("consultPerson", { passport });
}

function consultPrisonHistory() {
    const passport = Number(document.getElementById("prisonPassport")?.value || document.getElementById("personPassport")?.value || 0);
    request("consultPerson", { passport });
}

function consultVehicle() {
    request("consultVehicle", {
        search: document.getElementById("vehicleSearch")?.value || ""
    });
}

function registerPrison() {
    const passport = Number(document.getElementById("prisonPassport")?.value || document.getElementById("personPassport")?.value || 0);
    const totalPrison = Number(document.getElementById("totalPrison")?.value || 0);

    if (totalPrison <= 0) {
        notify("amarelo", "A pena total precisa ser maior que 0 para registrar a prisão.");
        return;
    }

    request("registerPrison", {
        passport,
        articles: state.selectedPrisonArticles,
        additional_prison: Number(document.getElementById("additionalPrison")?.value || 0),
        additional_fine: Number(document.getElementById("additionalFine")?.value || 0),
        observation: document.getElementById("prisonObservation")?.value || ""
    });
}

function registerSeizure() {
    const passport = Number(document.getElementById("prisonPassport")?.value || document.getElementById("personPassport")?.value || 0);
    request("registerSeizure", {
        passport,
        item_name: document.getElementById("seizureItemName")?.value || "",
        item_amount: Number(document.getElementById("seizureItemAmount")?.value || 0),
        observation: document.getElementById("prisonObservation")?.value || ""
    });
}

function clearArticleForm() {
    const code = document.getElementById("articleCode");
    const title = document.getElementById("articleTitle");
    const fine = document.getElementById("articleFine");
    const jail = document.getElementById("articleJail");
    const description = document.getElementById("articleDescription");

    if (code) code.value = "";
    if (title) title.value = "";
    if (fine) fine.value = "";
    if (jail) jail.value = "";
    if (description) description.value = "";
}

function updateArticleFormState() {
    const submitBtn = document.getElementById("articleSubmitBtn");
    const cancelBtn = document.getElementById("articleCancelBtn");
    const form = document.querySelector("#tab-articles .article-form");
    const permissions = getArticlePermissions();
    const isEditing = !!state.currentArticleId;
    const canSubmit = isEditing ? !!permissions.edit : !!permissions.create;

    if (submitBtn) {
        submitBtn.textContent = isEditing ? "Salvar edição" : "Cadastrar artigo";
        submitBtn.style.display = canSubmit ? "block" : "none";
    }

    if (cancelBtn) cancelBtn.style.display = isEditing && permissions.edit ? "block" : "none";

    if (form) {
        form.querySelectorAll("input, textarea").forEach((field) => {
            field.disabled = !canSubmit;
        });
    }
}

function cancelArticleEdit() {
    state.currentArticleId = null;
    clearArticleForm();
    updateArticleFormState();
}

function editArticle(articleId) {
    if (!canEditArticle()) return;

    const article = state.articles.find((item) => Number(item.id) === Number(articleId));
    if (!article) return;

    state.currentArticleId = Number(article.id);

    const code = document.getElementById("articleCode");
    const title = document.getElementById("articleTitle");
    const fine = document.getElementById("articleFine");
    const jail = document.getElementById("articleJail");
    const description = document.getElementById("articleDescription");

    if (code) code.value = article.code || "";
    if (title) title.value = article.title || "";
    if (fine) fine.value = Number(article.fine_value || 0);
    if (jail) jail.value = Number(article.jail_time || 0);
    if (description) description.value = article.description || "";

    updateArticleFormState();
}

function deleteArticle(articleId) {
    if (!canDeleteArticle() || !articleId) return;
    request("deleteArticle", { article_id: Number(articleId) });

    if (state.currentArticleId && Number(state.currentArticleId) === Number(articleId)) {
        cancelArticleEdit();
    }
}

function saveArticle() {
    if (state.currentArticleId) {
        if (!canEditArticle()) return;
    } else {
        if (!canCreateArticle()) return;
    }

    const payload = {
        code: document.getElementById("articleCode")?.value || "",
        title: document.getElementById("articleTitle")?.value || "",
        fine_value: Number(document.getElementById("articleFine")?.value || 0),
        jail_time: Number(document.getElementById("articleJail")?.value || 0),
        description: document.getElementById("articleDescription")?.value || ""
    };

    if (state.currentArticleId) {
        payload.article_id = Number(state.currentArticleId);
        request("updateArticle", payload);
    } else {
        request("createArticle", payload);
    }

    cancelArticleEdit();
}

document.addEventListener("input", (event) => {
    if (["additionalPrison", "additionalFine"].includes(event.target.id)) {
        updatePrisonTotals();
    }
});

function unlockTablet() {
    fetch(`https://${GetParentResourceName()}/unlock`, { method: "POST" });
}

function closeTablet() {
    fetch(`https://${GetParentResourceName()}/close`, { method: "POST" });
}

document.addEventListener("keyup", (event) => {
    if (event.key === "Escape") {
        closeTablet();
    }
});

function formatMoney(value) {
    const number = Number(value || 0);
    return `R$ ${number.toLocaleString("pt-BR")}`;
}

function formatDate(date) {
    if (date === null || date === undefined || date === "") return "---";

    if (typeof date === "number" || /^\d+$/.test(String(date))) {
        const numeric = Number(date);
        if (!Number.isNaN(numeric) && numeric > 0) {
            const parsedNumeric = new Date(numeric);
            if (!Number.isNaN(parsedNumeric.getTime())) {
                return parsedNumeric.toLocaleString("pt-BR");
            }
        }
    }

    const parsed = new Date(String(date).replace(" ", "T"));
    if (Number.isNaN(parsed.getTime())) return "---";
    return parsed.toLocaleString("pt-BR");
}

function escapeAttribute(value) {
    return String(value ?? "")
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
}

function escapeHtml(value) {
    return String(value ?? "")
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

function hexToRgba(hex, alpha) {
    const normalized = String(hex || "#2f6dff").replace("#", "");
    const bigint = parseInt(normalized, 16);

    if (Number.isNaN(bigint)) {
        return `rgba(47, 109, 255, ${alpha})`;
    }

    const r = (bigint >> 16) & 255;
    const g = (bigint >> 8) & 255;
    const b = bigint & 255;
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}