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
        const root = document.documentElement;

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
        const scheme =
            pref === "auto" || !pref ? getSystem() : pref;

        root.setAttribute("data-color-scheme", scheme);
        syncHighlighterTheme();
    }

    matchMedia("(prefers-color-scheme: dark)").addEventListener("change", () => {
        if (getPref() === "auto") applyScheme("auto");
    });

    // Initialize on load
    applyScheme(getPref());
})();
