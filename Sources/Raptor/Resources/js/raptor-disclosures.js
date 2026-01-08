/* -------------------------------------------------------------------------- */
/* SMART DISCLOSURES                                                          */
/* -------------------------------------------------------------------------- */

class SmartDisclosure {
    constructor(el) {
        this.el = el;
        this.summary = el.querySelector('.summary');
        this.content = el.querySelector('.disc-content');
        this.animation = null;
        this.isClosing = false;
        this.isExpanding = false;

        this.summary.addEventListener('click', (e) => this.onClick(e));
        this.summary.addEventListener('keydown', (e) => this.onKeyDown(e));
    }

    onClick(e) {
        e.preventDefault();
        this.toggle();
    }

    onKeyDown(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            this.toggle();
        }
    }

    toggle() {
        this.el.style.overflow = 'hidden';

        if (this.isClosing || !this.el.open) {
            this.open();
        } else if (this.isExpanding || this.el.open) {
            this.shrink();
        }
    }

    getAnimationProperties() {
        const computedStyle = getComputedStyle(this.el);
        const durationValue = computedStyle.getPropertyValue('--disc-duration') ||
        computedStyle.getPropertyValue('--anim-duration') ||
        '0.2s';
        const duration = parseFloat(durationValue) * 1000;
        const easing = computedStyle.getPropertyValue('--disc-easing') ||
        computedStyle.getPropertyValue('--anim-easing') ||
        'cubic-bezier(0.25, 0.46, 0.45, 0.94)';
        if (duration <= 0) return null;
        return { duration, easing };
    }

    shrink() {
        this.isClosing = true;
        this.summary.classList.add('closing');
        this.summary.classList.remove('hovered');
        this.summary.setAttribute('aria-expanded', 'false');

        // Measure before closing
        const startHeight = `${this.el.offsetHeight}px`;
        const endHeight = `${this.summary.offsetHeight}px`;

        if (this.animation) this.animation.cancel();

        const props = this.getAnimationProperties();

        // Temporarily fix height before removing [open]
        this.el.style.height = startHeight;
        this.el.style.overflow = 'hidden';

        // Defer removing [open] to next frame
        requestAnimationFrame(() => {
            this.el.open = false; // remove attribute AFTER we captured height

            if (props) {
                this.animation = this.el.animate(
                    { height: [startHeight, endHeight] },
                    props
                    );

                this.animation.onfinish = () => this.onAnimationFinish(false);
                this.animation.oncancel = () => (this.isClosing = false);
            } else {
                this.el.style.height = endHeight;
                this.onAnimationFinish(false);
            }
        });
    }

    open() {
        this.el.style.height = `${this.el.offsetHeight}px`;
        this.el.open = true;
        this.summary.setAttribute('aria-expanded', 'true');
        window.requestAnimationFrame(() => this.expand());
    }

    expand() {
        this.isExpanding = true;
        const startHeight = `${this.el.offsetHeight}px`;
        const endHeight = `${this.summary.offsetHeight + this.content.offsetHeight}px`;

        if (this.animation) this.animation.cancel();

        const props = this.getAnimationProperties();
        if (props) {
            this.animation = this.el.animate({ height: [startHeight, endHeight] }, props);
            this.animation.onfinish = () => this.onAnimationFinish(true);
            this.animation.oncancel = () => (this.isExpanding = false);
        } else {
            this.el.style.height = endHeight;
            this.onAnimationFinish(true);
        }
    }

    onAnimationFinish(open) {
        this.el.open = open;
        this.animation = null;
        this.isClosing = false;
        this.isExpanding = false;
        this.el.style.height = this.el.style.overflow = '';
        this.summary.removeAttribute('data-state');
    }
}

// Initialize all <details>
document.querySelectorAll('details.disclosure').forEach((el) => new SmartDisclosure(el));
