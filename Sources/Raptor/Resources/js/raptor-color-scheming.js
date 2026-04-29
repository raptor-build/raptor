(function () {
    const root = document.documentElement;
    const COLOR_KEY = "color-scheme";

    function getPref() {
        return localStorage.getItem(COLOR_KEY) || "auto";
    }

    function setPref(value) {
        localStorage.setItem(COLOR_KEY, value);
        applyScheme(value);
    }

    function getSystem() {
        return matchMedia("(prefers-color-scheme: dark)").matches
        ? "dark"
        : "light";
    }

    function syncHighlighterTheme() {
        const blockTheme = getComputedStyle(root)
        .getPropertyValue("--highlighter-theme")
        .trim()
        .replace(/"/g, "");

        const inlineTheme = getComputedStyle(root)
        .getPropertyValue("--inline-highlighter-theme")
        .trim()
        .replace(/"/g, "");

        if (blockTheme) {
            root.setAttribute("data-highlighter-theme", blockTheme);
        }

        if (inlineTheme) {
            root.setAttribute("data-inline-highlighter-theme", inlineTheme);
        }
    }

    function applyScheme(pref) {
        const scheme = pref === "auto" || !pref ? getSystem() : pref;
        root.setAttribute("data-color-scheme", scheme);
        syncHighlighterTheme();
    }

    matchMedia("(prefers-color-scheme: dark)").addEventListener("change", () => {
        if (getPref() === "auto") applyScheme("auto");
    });

    // Initialize on load
    if (root.hasAttribute("data-lock-scheme")) {
        const locked = root.getAttribute("data-color-scheme") || "dark";
        root.setAttribute("data-color-scheme", locked);
        syncHighlighterTheme();
        // Restore storage to whatever it was before — don't let the locked
        // page's scheme pollute it
        const existing = localStorage.getItem(COLOR_KEY);
        if (existing === "dark" || existing === "light") {
            localStorage.setItem(COLOR_KEY, "auto");
        }
    } else {
        applyScheme(getPref());
    }
})();
