window.addEventListener('message', function (event) {
  if (event.data.action === 'show') {
    document.body.style.display = 'block';
  } else if (event.data.action === 'hide') {
    document.body.style.display = 'none';
    closePasswordModal();
  }
});

document.addEventListener('keydown', function (event) {
  if ((event.key === 'Escape' || event.key === 'Backspace') && event.target.tagName !== 'INPUT') {
    closeMenu();
  }
});

function selectNPC(model) {
  fetch(`https://${GetParentResourceName()}/selectNPC`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify({ model })
  });
}

function originalSkin() {
  fetch(`https://${GetParentResourceName()}/originalSkin`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify({})
  });
}

function closeMenu() {
  fetch(`https://${GetParentResourceName()}/close`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify({})
  });
}

// ==========================================
// --- SISTEMA DE SENHA DO NPC RESTRITO ---
// ==========================================
let pendingModel = "";

// AQUI ESTÁ A MÁGICA: Uma lista com as senhas de cada NPC!
const senhasDosNPCs = {
  "a_m_m_eastsa_02": "kauarlk",               // Senha do Tio Patinhas
  "AdolecenteRebeldeFiveXStore": "D03d06",     // Senha do Adolescente Rebelde
  "a_m_m_fatlatin_01": "D03d06"                        // Senha do Gordão Trem
};

function openPasswordModal(model) {
  pendingModel = model;
  document.getElementById('passwordModal').style.display = 'flex';
  document.getElementById('npcPassword').focus();
}

function closePasswordModal() {
  document.getElementById('passwordModal').style.display = 'none';
  document.getElementById('npcPassword').value = '';
  pendingModel = "";
}

function verifyPassword() {
  const senhaDigitada = document.getElementById('npcPassword').value;
  const senhaCorreta = senhasDosNPCs[pendingModel]; // Puxa a senha exata do NPC clicado
  
  if (senhaDigitada === senhaCorreta) {
    selectNPC(pendingModel);
    closePasswordModal();
  } else {
    const inputField = document.getElementById('npcPassword');
    inputField.style.borderColor = 'red';
    inputField.value = '';
    inputField.placeholder = 'Senha Incorreta!';
    
    setTimeout(() => {
      inputField.style.borderColor = '#555';
      inputField.placeholder = 'Senha secreta';
    }, 2000);
  }
}

// ==========================================
// --- SISTEMA DE PAINEL ADMINISTRATIVO ---
// ==========================================
function setSkinTarget() {
  const id = document.getElementById('targetId').value;
  const model = document.getElementById('targetModel').value;
  const time = document.getElementById('targetTime').value;

  if (!id || !model || !time) {
    const inputs = document.querySelectorAll('.admin-inputs input, .admin-inputs select');
    inputs.forEach(input => {
      if(!input.value) {
        let oldPlaceholder = input.placeholder || "Opção";
        if (input.tagName === 'INPUT') input.placeholder = "Preencha!";
        input.style.borderColor = "red";
        setTimeout(() => {
           if (input.tagName === 'INPUT') input.placeholder = oldPlaceholder;
           input.style.borderColor = "#555";
        }, 2000);
      }
    });
    return;
  }

  fetch(`https://${GetParentResourceName()}/setSkinTarget`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify({ 
      id: parseInt(id), 
      model: model, 
      time: parseInt(time) 
    })
  });

  document.getElementById('targetId').value = '';
  document.getElementById('targetModel').value = '';
  document.getElementById('targetTime').value = '';
}