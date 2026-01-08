/* -------------------------------------------------------------------------- */
/* THEME SWITCHING                                                            */
/* -------------------------------------------------------------------------- */

const root = document.documentElement;
const THEME_KEY = "custom-theme-id";
const COLOR_KEY = "color-scheme";

// ---------------------------------------------------------------------------
// COLOR SCHEME
// ---------------------------------------------------------------------------

function getSystemScheme() {
    return window.matchMedia("(prefers-color-scheme: dark)").matches
        ? "dark"
        : "light";
}

function getColorPreference() {
    return localStorage.getItem(COLOR_KEY) || "auto";
}

function setColorScheme(scheme) {
    localStorage.setItem(COLOR_KEY, scheme);
    applyColorScheme(scheme);
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

function applyColorScheme(scheme) {
    const resolved =
        scheme === "auto" || !scheme
            ? getSystemScheme()
            : scheme;

    root.setAttribute("data-color-scheme", resolved);
    syncHighlighterTheme();
}

// ---------------------------------------------------------------------------
// THEME FAMILY
// ---------------------------------------------------------------------------

function getThemePreference() {
    return localStorage.getItem(THEME_KEY) || null;
}

function setTheme(themeID) {
    if (themeID) {
        localStorage.setItem(THEME_KEY, themeID);
        root.setAttribute("data-theme", themeID);
    } else {
        localStorage.removeItem(THEME_KEY);
        root.removeAttribute("data-theme");
    }

    syncHighlighterTheme();
}

// ---------------------------------------------------------------------------
// SYSTEM CHANGE LISTENER
// ---------------------------------------------------------------------------

window
    .matchMedia("(prefers-color-scheme: dark)")
    .addEventListener("change", () => {
        if (getColorPreference() === "auto") {
            applyColorScheme("auto");
        }
    });

// ---------------------------------------------------------------------------
// INITIALIZATION
// ---------------------------------------------------------------------------

(function init() {
    // Respect hard lock if present
    if (root.hasAttribute("data-lock-scheme")) {
        const locked =
            root.getAttribute("data-color-scheme") || "light";

        root.setAttribute("data-color-scheme", locked);
        localStorage.setItem(COLOR_KEY, locked);
        return;
    }

    const savedTheme = getThemePreference();
    const savedScheme = getColorPreference();

    if (savedTheme) {
        root.setAttribute("data-theme", savedTheme);
    }

    applyColorScheme(savedScheme);
})();
