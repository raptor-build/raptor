(function () {
    const STORAGE_PREFIX = 'segmented-control:';

    function initControl(control) {
        if (control.hasAttribute('data-initialized')) return;

        const segments = control.querySelectorAll('.segment');
        const persist = control.hasAttribute('data-persist-selection');

        const key = persist
            ? STORAGE_PREFIX + (control.getAttribute('data-selected-segment') ?? 'default')
            : null;

        let activeIndex = 0;

        // Restore persisted value
        if (key) {
            const saved = parseInt(localStorage.getItem(key), 10);
            if (!isNaN(saved) && segments[saved]) {
                activeIndex = saved;
            }
        }

        // Default selection fallback
        if (activeIndex === 0) {
            const def = [...segments]
                .findIndex(s => s.hasAttribute('data-default-selection'));
            if (def !== -1) activeIndex = def;
        }

        // Apply initial state
        segments.forEach((seg, i) =>
            seg.classList.toggle('active', i === activeIndex)
        );

        // Click handling
        segments.forEach((segment, index) => {
            segment.addEventListener('click', (e) => {
                if (segment.classList.contains('active')) {
                    e.preventDefault();
                    e.stopImmediatePropagation();
                    return;
                }

                segments.forEach(s => s.classList.remove('active'));
                segment.classList.add('active');

                if (key) {
                    localStorage.setItem(key, index);
                }

                control.dispatchEvent(new CustomEvent('segmentChange', {
                    detail: {
                        index,
                        label: segment.textContent.trim(),
                        control
                    }
                }));
            }, true);
        });

        control.setAttribute('data-initialized', 'true');
    }

    // Init any controls already in DOM
    document.querySelectorAll('.segmented-control')
        .forEach(initControl);

    // Observe future additions
    new MutationObserver(mutations => {
        for (const m of mutations) {
            m.addedNodes.forEach(node => {
                if (node.nodeType !== 1) return;

                if (node.matches?.('.segmented-control')) {
                    initControl(node);
                }

                node.querySelectorAll?.('.segmented-control')
                    .forEach(initControl);
            });
        }
    }).observe(document.documentElement, {
        childList: true,
        subtree: true
    });
})();
