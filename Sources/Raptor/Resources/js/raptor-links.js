/* -------------------------------------------------------------------------- */
/* LINK PROTECTION                                                */
/* -------------------------------------------------------------------------- */

function encodeEmail(email) { return btoa(email); }
function decode(encoded) { return atob(encoded); }

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.protected-link').forEach(link => {
        try { link.textContent = decode(link.textContent); } catch {}
    });
});

document.addEventListener('click', e => {
    const protectedLink = e.target.closest('.protected-link');
    if (!protectedLink) return;
    e.preventDefault();
    window.location.href = decode(protectedLink.getAttribute('data-encoded-url'));
});
