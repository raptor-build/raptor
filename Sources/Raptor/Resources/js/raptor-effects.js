(function () {
    function normalize(ids) {
        return Array.isArray(ids) ? ids : [ids];
    }

    function addTrait(elementIDs, attribute) {
        normalize(elementIDs).forEach(id => {
            const el = document.getElementById(id);
            if (el) el.setAttribute(attribute, "");
        });
    }

    function removeTrait(elementIDs, attribute) {
        normalize(elementIDs).forEach(id => {
            const el = document.getElementById(id);
            if (el) el.removeAttribute(attribute);
        });
    }

    function toggleTrait(elementIDs, attribute) {
        normalize(elementIDs).forEach(id => {
            const el = document.getElementById(id);
            if (!el) return;

            if (el.hasAttribute(attribute)) {
                el.removeAttribute(attribute);
            } else {
                el.setAttribute(attribute, "");
            }
        });
    }

    // Namespaced public API
    window.RaptorIdentity = {
        add: addTrait,
        remove: removeTrait,
        toggle: toggleTrait
    };
})();
