let currentData = null;

function handleActionResponse(response) {
    if (!response || response.success !== false) return response;

    if (response.orgData) {
        currentData = response.orgData;
        updatePanel();
    }

    return response;
}

window.addEventListener("message", (event) => {
    const payload = event.data;

    if (payload.action === "openPanel") {
        currentData = payload.data;
        openPanel();
        updatePanel();
    } else if (payload.action === "closePanel") {
        closePanel(false);
    } else if (payload.action === "updateData") {
        currentData = payload.data || payload.payload || payload;
        updatePanel();
    }
});

function openPanel() {
    const container = document.getElementById("container");
    if (!container) return;

    container.classList.remove("hidden");
    container.classList.add("active");
}

function closePanel(sendCallback = true) {
    const container = document.getElementById("container");
    if (container) {
        container.classList.remove("active");
        container.classList.add("hidden");
    }

    closeModalOnly();

    if (sendCallback) {
        sendNUI("closePanel", {});
    }
}

document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        const modal = document.getElementById("modal");
        if (modal && !modal.classList.contains("hidden")) {
            closeModalOnly();
        } else {
            closePanel();
        }
    }
});

function showSection(section, evt = null) {
    document.querySelectorAll(".nav-item").forEach((item) => {
        item.classList.remove("active");
    });

    const triggerEvent = evt || window.event;
    if (triggerEvent && triggerEvent.target) {
        const navItem = triggerEvent.target.closest(".nav-item");
        if (navItem) navItem.classList.add("active");
    }

    document.querySelectorAll(".section").forEach((item) => {
        item.classList.remove("active");
    });

    const sectionElement = document.getElementById(section + "-section");
    if (sectionElement) {
        sectionElement.classList.add("active");
    }
}

function updatePanel() {
    if (!currentData) return;

    const bankBalance = document.getElementById("bankBalance");
    const onlineMembers = document.getElementById("onlineMembers");
    const totalMembers = document.getElementById("totalMembers");
    const orgName = document.getElementById("orgName");

    if (bankBalance) bankBalance.textContent = "R$ " + formatMoney(currentData.bank || 0);
    if (onlineMembers) onlineMembers.textContent = `${currentData.onlineMembers || 0} PLAYERS`;
    if (totalMembers) totalMembers.textContent = `${currentData.totalMembers || 0}/${currentData.maxMembers || 0}`;
    if (orgName && currentData.orgName) orgName.textContent = String(currentData.orgName).toUpperCase();

    updateMembersList();
    updateTransactionsList();
    updateChestLogsList();
    updateRankingList();
}

function updateMembersList() {
    const membersList = document.getElementById("membersList");
    if (!membersList) return;

    membersList.innerHTML = "";

    if (!currentData.members || currentData.members.length === 0) {
        membersList.innerHTML = `<div style="padding: 40px; text-align: center; color: rgba(255,255,255,0.4);">Nenhum membro encontrado</div>`;
        return;
    }

    currentData.members.forEach((member) => {
        const row = document.createElement("div");
        row.className = "table-row";

        const statusClass = member.online ? "status-online" : "status-offline";
        const playTime = formatPlayTime(member.playTime || member.play_time || 0);
        const hiredDate = formatDate(member.hired_date || member.joinDate || member.join_date, true);
        const lastLogin = formatDate(member.lastLogin || member.last_login, false);

        const actions = `
            <div class="row-actions">
                <button class="btn-promote" onclick="promoteMember(${member.id})">PROMOVER</button>
                <button class="btn-demote" onclick="demoteMember(${member.id})">REBAIXAR</button>
            </div>
        `;

        row.innerHTML = `
            <div><span class="${statusClass}"></span>${member.name || "Sem nome"}</div>
            <div>${member.rank || member.role || member.roleName || "Sem Cargo"}</div>
            <div>${hiredDate}</div>
            <div>${lastLogin}</div>
            <div>${playTime}</div>
            ${actions}
        `;

        membersList.appendChild(row);
    });
}

function updateTransactionsList() {
    const transactionsList = document.getElementById("transactionsList");
    if (!transactionsList) return;

    transactionsList.innerHTML = "";

    if (!currentData.transactions || currentData.transactions.length === 0) {
        transactionsList.innerHTML = `<div style="padding: 40px; text-align: center; color: rgba(255,255,255,0.4);">Nenhuma transação recente</div>`;
        return;
    }

    currentData.transactions.forEach((transaction) => {
        const row = document.createElement("div");
        row.className = "table-row";

        const color = transaction.type === "deposit" ? "#4ade80" : "#ef4444";
        const prefix = transaction.type === "deposit" ? "+" : "-";

        row.innerHTML = `
            <div>${transaction.name || "Desconhecido"}</div>
            <div>${transaction.rank || transaction.role || transaction.roleName || "Sem Cargo"}</div>
            <div>${formatDate(transaction.date)}</div>
            <div>${transaction.action || "-"}</div>
            <div style="color: ${color}; font-weight: 700;">${prefix}R$ ${formatMoney(transaction.value || transaction.amount || 0)}</div>
        `;

        transactionsList.appendChild(row);
    });
}

function updateChestLogsList() {
    const chestLogsList = document.getElementById("chestLogsList");
    if (!chestLogsList) return;

    chestLogsList.innerHTML = "";

    if (!currentData.chestLogs || currentData.chestLogs.length === 0) {
        chestLogsList.innerHTML = `<div style="padding: 20px; text-align: center; color: rgba(255,255,255,0.4);">Nenhum log registrado</div>`;
        return;
    }

    currentData.chestLogs.forEach((log) => {
        const row = document.createElement("div");
        row.className = "table-row";

        const actionText = log.action === "store" ? "GUARDOU" : "RETIROU";
        const actionColor = log.action === "store" ? "#4ade80" : "#ef4444";

        let roleColor = "#94a3b8";
        if (log.role === "Líder" || log.role === "Gerente") {
            roleColor = "#fbbf24";
        }

        row.innerHTML = `
            <div>${log.name || "Desconhecido"}</div>
            <div style="color: ${roleColor}; font-weight: 600;">${log.role || "-"}</div>
            <div style="color: ${actionColor}; font-weight: 700;">${actionText}</div>
            <div>${log.itemName || "-"}</div>
            <div>${log.amount || 0}x</div>
            <div>${formatDate(log.date)}</div>
        `;

        chestLogsList.appendChild(row);
    });
}

function updateRankingList() {
    const rankingList = document.getElementById("rankingList");
    if (!rankingList) return;

    rankingList.innerHTML = "";

    if (!currentData.ranking || currentData.ranking.length === 0) {
        rankingList.innerHTML = `<div style="padding: 40px; text-align: center; color: rgba(255,255,255,0.4);">Nenhum dado de ranking</div>`;
        return;
    }

    currentData.ranking.forEach((item, index) => {
        const row = document.createElement("div");
        row.className = "table-row";
        row.innerHTML = `
            <div>#${index + 1}</div>
            <div>${item.name || "Desconhecido"}</div>
            <div>${item.hires || item.amount || 0}</div>
        `;
        rankingList.appendChild(row);
    });
}

function searchMembers() {
    const input = document.getElementById("searchMember");
    if (!input) return;

    const search = input.value.toLowerCase();
    const rows = document.querySelectorAll("#membersList .table-row");

    rows.forEach((row) => {
        const content = row.textContent.toLowerCase();
        row.style.display = content.includes(search) ? "grid" : "none";
    });
}

function showHireModal() {
    showModal(
        "Contratar",
        `
        <div class="modal-text">Digite o passaporte do jogador que deseja contratar</div>
        <input type="number" class="modal-input" id="hirePassport" placeholder="Passaporte">
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmHire()">CONFIRMAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function showFireModal() {
    showModal(
        "Demitir",
        `
        <div class="modal-text">Digite o passaporte que deseja demitir</div>
        <input type="number" class="modal-input" id="firePassport" placeholder="Passaporte">
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmFire()">CONFIRMAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function promoteMember(id) {
    const member = currentData.members.find((member) => member.id === id);
    if (!member) return;

    showModal(
        "Promover",
        `
        <div class="modal-text">Deseja realmente promover ${member.name}?</div>
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmPromote(${id})">CONFIRMAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function demoteMember(id) {
    const member = currentData.members.find((member) => member.id === id);
    if (!member) return;

    showModal(
        "Rebaixar",
        `
        <div class="modal-text">Deseja realmente rebaixar ${member.name}?</div>
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmDemote(${id})">CONFIRMAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function showEditGoalsModal() {
    let goalsHtml = "";

    if (currentData.goals) {
        currentData.goals.forEach((goal, index) => {
            goalsHtml += `
                <div style="margin-bottom: 20px;">
                    <div style="font-size: 14px; font-weight: 600; margin-bottom: 10px; color: rgba(255,255,255,0.8);">${goal.item}</div>
                    <input type="number" class="modal-input" id="goalTarget${index}" placeholder="Quantidade" value="${goal.target}">
                </div>
            `;
        });
    }

    showModal(
        "Editar Metas",
        `
        ${goalsHtml}
        <div style="margin-bottom: 20px;">
            <div style="font-size: 14px; font-weight: 600; margin-bottom: 10px; color: rgba(255,255,255,0.8);">Valor da premiação</div>
            <input type="number" class="modal-input" id="rewardInput" placeholder="Valor" value="${currentData.rewardValue || 0}">
        </div>
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmEditGoals()">CONFIRMAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function refreshOrgData(delay = 300) {
    if (!currentData || !currentData.org) return Promise.resolve(null);

    return new Promise((resolve) => {
        setTimeout(() => {
            sendNUI("refreshData", { org: currentData.org }).then((data) => {
                if (data && !data.success === false) {
                    currentData = data;
                    updatePanel();
                }
                resolve(data);
            }).catch(() => resolve(null));
        }, delay);
    });
}

function confirmHire() {
    const input = document.getElementById("hirePassport");
    const passport = input ? input.value : null;

    if (!passport || !currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("hireMember", {
        org: currentData.org,
        passport: Number.parseInt(passport)
    }).then(handleActionResponse).then(() => refreshOrgData()).finally(() => {
        closeModalOnly();
    });
}

function confirmFire() {
    const input = document.getElementById("firePassport");
    const passport = input ? input.value : null;

    if (!passport || !currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("fireMember", {
        org: currentData.org,
        passport: Number.parseInt(passport),
        reason: "Demitido pela liderança"
    }).then(handleActionResponse).then(() => refreshOrgData()).finally(() => {
        closeModalOnly();
    });
}

function confirmPromote(passport) {
    if (!currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("promoteMember", {
        org: currentData.org,
        passport: passport
    }).then(handleActionResponse).then(() => refreshOrgData()).finally(() => {
        closeModalOnly();
    });
}

function confirmDemote(passport) {
    if (!currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("demoteMember", {
        org: currentData.org,
        passport: passport
    }).then(handleActionResponse).then(() => refreshOrgData()).finally(() => {
        closeModalOnly();
    });
}

function confirmEditGoals() {
    const goals = [];

    if (currentData.goals) {
        currentData.goals.forEach((goal, index) => {
            const input = document.getElementById(`goalTarget${index}`);
            const value = input ? input.value : 0;
            goals.push({
                item: goal.item,
                target: Number.parseInt(value) || 0
            });
        });
    }

    const rewardInput = document.getElementById("rewardInput");
    const reward = rewardInput ? rewardInput.value : 0;

    sendNUI("saveGoals", {
        goals: goals,
        reward: Number.parseInt(reward) || 0
    }).finally(() => {
        closeModalOnly();
    });
}

function deposit() {
    const input = document.getElementById("depositInput");
    const amount = input ? input.value : null;

    if (amount && amount > 0 && currentData && currentData.org) {
        sendNUI("deposit", {
            org: currentData.org,
            amount: Number.parseInt(amount)
        }).then(handleActionResponse).then(() => {
            if (input) input.value = "";
            return refreshOrgData();
        });
    }
}

function withdraw() {
    const input = document.getElementById("withdrawInput");
    const amount = input ? input.value : null;

    if (amount && amount > 0 && currentData && currentData.org) {
        sendNUI("withdraw", {
            org: currentData.org,
            amount: Number.parseInt(amount)
        }).then(handleActionResponse).then(() => {
            if (input) input.value = "";
            return refreshOrgData();
        });
    }
}

function pix() {
    const input = document.getElementById("pixInput");
    const passport = input ? input.value : null;

    if (passport) {
        showModal(
            "Transferir PIX",
            `
            <div class="modal-text">Digite o passaporte e valor para transferir</div>
            <input type="number" class="modal-input" id="pixPassportModal" placeholder="Passaporte" value="${passport}">
            <input type="number" class="modal-input" id="pixAmount" placeholder="Valor">
            <div class="modal-actions">
                <button class="btn-confirm" onclick="confirmPix()">CONFIRMAR</button>
                <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
            </div>
            `
        );
    }
}

function confirmPix() {
    const passportInput = document.getElementById("pixPassportModal");
    const amountInput = document.getElementById("pixAmount");

    const passport = passportInput ? passportInput.value : null;
    const amount = amountInput ? amountInput.value : null;

    if (!passport || !amount || amount <= 0 || !currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("pix", {
        org: currentData.org,
        passport: Number.parseInt(passport),
        amount: Number.parseInt(amount)
    }).then(handleActionResponse).then(() => {
        const originalInput = document.getElementById("pixInput");
        if (originalInput) originalInput.value = "";
        return refreshOrgData();
    }).finally(() => {
        closeModalOnly();
    });
}

function openRadio() {
    if (!currentData || !currentData.org) return;

    sendNUI("openRadio", {
        org: currentData.org,
        frequency: currentData.radioFrequency || "100.0"
    });
}

function openClothes() {
    if (!currentData || !currentData.org) return;

    sendNUI("openClothes", {
        org: currentData.org
    });
}

function configRadio() {
    if (!currentData || !currentData.org) return;

    showModal(
        "Configurar Rádio Automática",
        `
        <div class="modal-text">Digite a frequência da rádio que será configurada automaticamente para todos os membros online:</div>
        <input type="text" class="modal-input" id="radioFrequency" placeholder="Ex: 100.5">
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmConfigRadio()">CONFIGURAR</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function confirmConfigRadio() {
    const input = document.getElementById("radioFrequency");
    const frequency = input ? input.value : null;

    if (!frequency || !currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("setRadioFrequency", {
        org: currentData.org,
        frequency: frequency
    }).then(handleActionResponse).then(() => refreshOrgData(0)).finally(() => {
        closeModalOnly();
    });
}

function configClothes() {
    if (!currentData || !currentData.org) return;

    showModal(
        "Salvar Uniforme da Facção",
        `
        <div class="modal-text">Você está vestindo o uniforme que deseja salvar?</div>
        <div class="modal-text" style="color: rgba(239, 68, 68, 0.8); font-size: 12px; margin-top: 10px;">
            Sua roupa atual será salva como o uniforme oficial da facção!
        </div>
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmSaveClothes()">SALVAR UNIFORME</button>
            <button class="btn-cancel" onclick="closeModalOnly()">CANCELAR</button>
        </div>
        `
    );
}

function confirmSaveClothes() {
    if (!currentData || !currentData.org) {
        closeModalOnly();
        return;
    }

    sendNUI("saveUniform", {
        org: currentData.org
    }).then(handleActionResponse).finally(() => {
        closeModalOnly();
    });
}

function showModal(title, body) {
    const modal = document.getElementById("modal");
    const modalBody = document.getElementById("modalBody");

    if (!modal || !modalBody) return;

    modalBody.innerHTML = `
        <div class="modal-title">${title}</div>
        ${body}
    `;

    modal.classList.remove("hidden");
    modal.classList.add("active");
    modal.style.display = "flex";
    modal.style.pointerEvents = "auto";
    modal.style.opacity = "1";
}

function closeModalOnly() {
    const modal = document.getElementById("modal");
    const modalBody = document.getElementById("modalBody");

    if (modal) {
        modal.classList.remove("active");
        modal.classList.add("hidden");
        modal.style.pointerEvents = "none";
        modal.style.opacity = "0";
        modal.style.display = "none";
    }

    if (modalBody) {
        modalBody.innerHTML = "";
    }
}

function closeModal() {
    closeModalOnly();
}

function sendNUI(action, data) {
    if (!window.invokeNative) {
        return Promise.resolve({ success: true });
    }

    const resourceName = typeof window.GetParentResourceName === "function"
        ? window.GetParentResourceName()
        : "wn-org";

    return fetch(`https://${resourceName}/${action}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data || {})
    })
        .then((res) => res.json())
        .catch((err) => {
            return {
                success: false,
                error: err.message
            };
        });
}

function formatMoney(value) {
    if (!value) return "0";
    return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function formatDate(timestamp, todayLabel = false) {
    if (!timestamp || timestamp === 0) return "";

    const numericTimestamp = Number(timestamp);
    const date = new Date(numericTimestamp * 1000);

    if (isNaN(date.getTime())) return "Não disponível";

    if (todayLabel) {
        const now = new Date();
        const isToday =
            date.getDate() === now.getDate() &&
            date.getMonth() === now.getMonth() &&
            date.getFullYear() === now.getFullYear();

        if (isToday) return "Hoje";
    }

    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const year = date.getFullYear();
    const hours = String(date.getHours()).padStart(2, "0");
    const minutes = String(date.getMinutes()).padStart(2, "0");

    return `${day}/${month}/${year} ${hours}:${minutes}`;
}

function formatPlayTime(seconds) {
    if (!seconds || seconds === 0) return "";

    const totalSeconds = Number(seconds) || 0;
    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);

    return `${hours}h ${minutes}m`;
}
