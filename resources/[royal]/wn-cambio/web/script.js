let currentLocation = null;
let loadingTimeout = null;

const app = document.getElementById("app");
const loadingScreen = document.getElementById("loadingScreen");
const mainPanel = document.getElementById("mainPanel");

const title = document.getElementById("title");
const subtitle = document.getElementById("subtitle");
const amountInput = document.getElementById("amount");
const fromLabel = document.getElementById("fromLabel");
const toLabel = document.getElementById("toLabel");
const minAmount = document.getElementById("minAmount");
const stepAmount = document.getElementById("stepAmount");
const receiveAmount = document.getElementById("receiveAmount");
const rateInfo = document.getElementById("rateInfo");
const statusText = document.getElementById("statusText");
const requiredItemLabel = document.getElementById("requiredItemLabel");
const requiredItemAmount = document.getElementById("requiredItemAmount");

const closeBtn = document.getElementById("closeBtn");
const previewBtn = document.getElementById("previewBtn");
const exchangeBtn = document.getElementById("exchangeBtn");

window.addEventListener("message", function(event) {
    const data = event.data;

    if (data.action === "open") {
        currentLocation = data.location;
        app.style.display = "flex";

        loadingScreen.classList.remove("hidden");
        mainPanel.classList.add("hidden");

        title.innerText = currentLocation.name || "SISTEMA DE LAVAGEM";
        subtitle.innerText = "Painel de conversão financeira";
        fromLabel.innerText = currentLocation.fromLabel || "-";
        toLabel.innerText = currentLocation.toLabel || "-";
        minAmount.innerText = currentLocation.minAmount || 0;
        stepAmount.innerText = currentLocation.step || 0;
        rateInfo.innerText = `${currentLocation.rate}`;
        const openRequiredText = currentLocation.requiredItemsText || ((currentLocation.requiredItemLabel || currentLocation.requiredItem) ? `${currentLocation.requiredAmount || 0}x ${currentLocation.requiredItemLabel || currentLocation.requiredItem}` : "Nenhum");
        requiredItemLabel.innerText = "Itens exigidos";
        requiredItemAmount.innerText = openRequiredText;
        receiveAmount.innerText = "0";
        statusText.innerText = "Aguardando valor...";
        amountInput.value = "";

        if (loadingTimeout) {
            clearTimeout(loadingTimeout);
        }

        loadingTimeout = setTimeout(() => {
            loadingScreen.classList.add("hidden");
            mainPanel.classList.remove("hidden");
        }, 1800);
    }

    if (data.action === "close") {
        closePanel();
    }
});

function closePanel() {
    if (loadingTimeout) {
        clearTimeout(loadingTimeout);
        loadingTimeout = null;
    }

    app.style.display = "none";
    loadingScreen.classList.remove("hidden");
    mainPanel.classList.add("hidden");
    currentLocation = null;
}

async function post(eventName, data = {}) {
    const response = await fetch(`https://${GetParentResourceName()}/${eventName}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(data)
    });

    return await response.json();
}

closeBtn.addEventListener("click", async function() {
    await post("close");
    closePanel();
});

previewBtn.addEventListener("click", async function() {
    const amount = Number(amountInput.value) || 0;
    const result = await post("preview", { amount });

    if (result && result.ok) {
        receiveAmount.innerText = result.receiveAmount || 0;
        requiredItemLabel.innerText = "Itens exigidos";
        requiredItemAmount.innerText = result.requiredItemsText || "Nenhum";
        statusText.innerText = "Prévia calculada com sucesso.";
    } else {
        receiveAmount.innerText = "0";
        requiredItemAmount.innerText = currentLocation.requiredItemsText || "Nenhum";
        statusText.innerText = (result && result.message) || "Valor inválido.";
    }
});

exchangeBtn.addEventListener("click", async function() {
    const amount = Number(amountInput.value) || 0;
    const result = await post("exchange", { amount });

    if (result && result.ok) {
        receiveAmount.innerText = result.receiveAmount || 0;
        requiredItemAmount.innerText = result.requiredItemsText || requiredItemAmount.innerText || "Nenhum";
        statusText.innerText = result.message || "Troca realizada.";
    } else {
        statusText.innerText = (result && result.message) || "Erro ao realizar troca.";
    }
});

amountInput.addEventListener("input", async function() {
    const amount = Number(amountInput.value) || 0;

    if (amount <= 0) {
        receiveAmount.innerText = "0";
        statusText.innerText = "Aguardando valor...";
        return;
    }

    const result = await post("preview", { amount });

    if (result && result.ok) {
        receiveAmount.innerText = result.receiveAmount || 0;
        statusText.innerText = "Prévia calculada automaticamente.";
    } else {
        receiveAmount.innerText = "0";
        requiredItemAmount.innerText = currentLocation.requiredItemsText || "Nenhum";
        statusText.innerText = (result && result.message) || "Valor inválido.";
    }
});

document.addEventListener("keyup", async function(event) {
    if (event.key === "Escape") {
        await post("close");
        closePanel();
    }
});