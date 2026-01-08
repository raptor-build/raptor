// =========================================================
// Multilingual Site Logic
// =========================================================

function setLocale(locale) {
    try {
        localStorage.setItem("preferredLocale", locale);
        document.documentElement.lang = locale;

        const base = window.location.origin;
        let currentPath = window.location.pathname
        .replace(/^\/[a-z]{2}(-[A-Z]{2})?\//, '') // remove existing locale prefix if any
        .replace(/^\/+/, ''); // strip leading slashes

        // Build the new URL cleanly
        let newURL = `${base}/${locale}`;
        if (currentPath.length > 0) {
            newURL += `/${currentPath}`;
        }

        // Navigate to the new locale path
        window.location.href = newURL;
    } catch (err) {
        console.error("Failed to switch locale:", err);
    }
}


// Raptor appear effect runtime
// Automatically reveals elements with `.appear` when they enter the viewport.

document.addEventListener("DOMContentLoaded", () => {
    const appearElements = document.querySelectorAll(".entry");
    const initialStates = new WeakMap();

    appearElements.forEach((el) => {
        const vars = (el.dataset.animVars || "")
            .split(",")
            .map(v => v.trim())
            .filter(Boolean);

        const computedStyle = getComputedStyle(el);
        const initialValues = {};

        // Capture current inline/computed values
        for (const varName of vars) {
            if (varName === "transition") continue;
            const value = computedStyle.getPropertyValue(varName).trim();
            initialValues[varName] = value;
        }

        initialStates.set(el, initialValues);
    });

    const observer = new IntersectionObserver(entries => {
        for (const entry of entries) {
            const el = entry.target;
            const isVisible = entry.isIntersecting;

            if (isVisible) {
                el.classList.add("visible");
            } else {
                el.classList.remove("visible");

                const initialValues = initialStates.get(el);
                if (initialValues) {
                    for (const [varName, value] of Object.entries(initialValues)) {
                        el.style.setProperty(varName, value);
                    }
                }
            }
        }
    }, { threshold: 0.15 });

    appearElements.forEach(el => observer.observe(el));
});
