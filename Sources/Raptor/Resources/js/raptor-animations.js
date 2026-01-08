/* -------------------------------------------------------------------------- */
/* ANIMATIONS                                                                 */
/* -------------------------------------------------------------------------- */

document.addEventListener("DOMContentLoaded", () => {
    // --- Entry animations ---
    const entryElements = document.querySelectorAll('[class^="animation-entry-"]');
    window.addEventListener("load", () => {
        const observer = new IntersectionObserver(entries => {
            for (const entry of entries) {
                entry.target.classList.toggle("in-view", entry.isIntersecting);
            }
        }, { threshold: 0.2 });
        entryElements.forEach(el => observer.observe(el));
    });

    // --- Tap animations ---
    document.querySelectorAll('[class^="animation-tap-"]').forEach(el => {
        let isAnimating = false;
        let hasPlayedOnce = false;

        el.addEventListener("animationend", () => {
            isAnimating = false;
        });

        el.addEventListener("click", () => {
            if (isAnimating) return; // Wait until animation finishes

            const computed = getComputedStyle(el);
            const dir = computed.animationDirection;
            const isReversible =
            dir.includes("alternate") || dir.includes("alternate-reverse");

            el.classList.remove("active");
            void el.offsetWidth;

            // Only toggle direction if animation is marked as reversible
            if (hasPlayedOnce && isReversible) {
                el.classList.toggle("reverse-mode");
            }

            el.classList.add("active");
            hasPlayedOnce = true;
            isAnimating = true;
        });
    });
});
