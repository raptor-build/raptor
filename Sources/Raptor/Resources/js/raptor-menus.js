/* -------------------------------------------------------------------------- */
/* MENUS                                                                      */
/* -------------------------------------------------------------------------- */

(() => {
    // Open / Close logic
    document.addEventListener('click', e => {
        const button = e.target.closest('[data-toggle="dropdown"]');
        if (!button) return;
        e.stopPropagation();

        const menu = button.closest('.menu');
        if (!menu) return;

        // --- FIX: reliably find dropdown even if wrapped in .menu-group ---
        let sibling = button.nextElementSibling;
        while (sibling && !sibling.classList?.contains('menu-dropdown')) {
            sibling = sibling.nextElementSibling;
        }
        const dropdown = sibling || menu.querySelector(':scope > .menu-dropdown');

        if (!dropdown) return;

        // Close all other menus
        document.querySelectorAll('.menu-dropdown[data-show]').forEach(m => {
            if (m !== dropdown) closeDropdown(m);
        });

        // Toggle current
        dropdown.getAttribute('data-show') === 'true'
        ? closeDropdown(dropdown)
        : openDropdown(dropdown);
    });

    function openDropdown(dropdown) {
        dropdown.style.display = 'block';
        dropdown.offsetHeight;
        dropdown.setAttribute('data-show', 'true');
        adjustHeight(dropdown);
        attachAutoDismiss(dropdown);
    }

    function closeDropdown(dropdown) {
        dropdown.removeAttribute('data-show');
        setTimeout(() => {
            if (!dropdown.hasAttribute('data-show')) dropdown.style.display = '';
        }, 150);
    }

    // Adjust max-height when viewport resizes
    function adjustHeight(dropdown) {
        const rect = dropdown.getBoundingClientRect();
        const maxAvailable = window.innerHeight - Math.max(rect.top, 0) - 10;
        dropdown.style.maxHeight = `${maxAvailable}px`;
        dropdown.style.overflowY = 'auto';
    }

    window.addEventListener('resize', () => {
        document.querySelectorAll('.menu-dropdown[data-show="true"]').forEach(adjustHeight);
    });

    // Dismiss mode: auto/manual
    function attachAutoDismiss(dropdown) {
        const root = dropdown.closest('[data-menu-dismiss], [data-dismiss]');
        const mode = root?.getAttribute('data-menu-dismiss') || root?.getAttribute('data-dismiss') || 'auto';
        if (mode !== 'auto') return;

        dropdown.querySelectorAll('a, button').forEach(el => {
            if (el.matches('[data-toggle="dropdown"]') || el.disabled || el.getAttribute('aria-disabled') === 'true') return;
            el.addEventListener('click', () => closeDropdown(dropdown), { once: true });
        });
    }

    // Click outside
    document.addEventListener('click', e => {
        if (!e.target.closest('.menu, .menu-dropdown[data-show]')) {
            document.querySelectorAll('.menu-dropdown[data-show]').forEach(closeDropdown);
        }
    });

    // Escape closes menu
    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') {
            document.querySelectorAll('.menu-dropdown[data-show]').forEach(closeDropdown);
        }
    });
})();

/* -------------------------------------------------------------------------- */
/* SECTION 8: ACTIVE LINK HIGHLIGHT                                          */
/* -------------------------------------------------------------------------- */

document.addEventListener('DOMContentLoaded', () => {
    const currentPath = window.location.pathname.replace(/\/$/, '');
    const currentHost = window.location.host;

    document.querySelectorAll('.menu-dropdown a').forEach(link => {
        const href = link.getAttribute('href');
        if (!href) return;

        try {
            const url = new URL(href, window.location.origin);

            if (url.host !== currentHost) return;

            const linkPath = url.pathname.replace(/\/$/, '');
            if (linkPath === currentPath) {
                link.dataset.active = 'true';
            }
        } catch {
            // Ignore invalid or malformed URLs
        }
    });
});
