const cachedTop = localStorage.getItem('reserved-space-top');
const cachedBottom = localStorage.getItem('reserved-space-bottom');

if (cachedTop) {
    document.documentElement.style.setProperty('--reserved-space-top', cachedTop);
}

if (cachedBottom) {
    document.documentElement.style.setProperty('--reserved-space-bottom', cachedBottom);
}

window.addEventListener('load', () => {
    const header = document.querySelector('header.fixed-top');
    if (header) {
        const styles = getComputedStyle(header);
        const height =
            header.offsetHeight +
            parseFloat(styles.marginTop) +
            parseFloat(styles.marginBottom);

        document.documentElement.style.setProperty('--reserved-space-top', `${height}px`);
        localStorage.setItem('reserved-space-top', `${height}px`);
    } else {
        document.documentElement.style.removeProperty('--reserved-space-top');
        localStorage.removeItem('reserved-space-top');
    }

    const footer = document.querySelector('footer.fixed-bottom');
    if (footer) {
        const styles = getComputedStyle(footer);
        const height =
            footer.offsetHeight +
            parseFloat(styles.marginTop) +
            parseFloat(styles.marginBottom);

        document.documentElement.style.setProperty('--reserved-space-bottom', `${height}px`);
        localStorage.setItem('reserved-space-bottom', `${height}px`);
    } else {
        document.documentElement.style.removeProperty('--reserved-space-bottom');
        localStorage.removeItem('reserved-space-bottom');
    }
});
