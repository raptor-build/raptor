// =========================================================
// SCROLL VIEWS
// =========================================================

(function () {
    function initAutoplay(el) {
        const interval = Number(el.dataset.autoplayInterval);
        const loops = el.dataset.autoplayLoops === "true";
        const axis = el.dataset.scrollAxis;

        let index = 0;
        const slides = el.querySelectorAll(":scope > .scroll-group > *");
        const total = slides.length;

        const scrollBy = axis === "horizontal" ? "left" : "top";
        const scrollSize = axis === "horizontal" ? "scrollWidth" : "scrollHeight";

        setInterval(() => {
            if (loops) {
                index = (index + 1) % total;
            } else if (index < total - 1) {
                index++;
            } else {
                return;
            }

            const step = el[scrollSize] / total;
            el.scrollTo({
                [scrollBy]: index * step,
                behavior: "smooth"
            });
        }, interval);
    }

    document.addEventListener("DOMContentLoaded", () => {
        document
            .querySelectorAll("[data-scroll-autoplay]")
            .forEach(initAutoplay);
    });
})();

(function () {
    function getScrollView(id) {
        const el = document.getElementById(id);
        if (!el || el.children.length === 0) return null;
        return el;
    }

    function scrollAmount(el) {
        const items = el.querySelectorAll(":scope > .scroll-group > .scroll-item");
        if (!items.length) return 0;
        return el.scrollWidth / items.length;
    }

    function scrollBackward(id) {
        const el = getScrollView(id);
        if (!el) return;
        el.scrollBy({ left: -scrollAmount(el), behavior: 'smooth' });
    }

    function scrollForward(id) {
        const el = getScrollView(id);
        if (!el) return;
        el.scrollBy({ left: scrollAmount(el), behavior: 'smooth' });
    }

    function scrollTo(id, index) {
        const el = getScrollView(id);
        if (!el) return;

        const slide = el.children[index];
        if (!slide) return;

        slide.scrollIntoView({
            behavior: 'smooth',
            block: 'nearest',
            inline: 'center'
        });
    }

    // Namespaced public API
    window.RaptorScroll = {
        backward: scrollBackward,
        forward: scrollForward,
        to: scrollTo
    };
})();
