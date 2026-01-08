let searchIndex;
let searchDocuments = [];

// =========================================================
// Locale-aware base path detection
// =========================================================
function getBasePath() {
    const parts = window.location.pathname.split('/').filter(Boolean);
    if (parts.length > 0 && /^[a-z]{2}(-[a-z]{2})?$/.test(parts[0])) {
        return `/${parts[0]}/`;
    }
    return '/';
}

// Ensure BASE_PATH always ends with exactly one slash
const BASE_PATH = getBasePath().replace(/\/+$/, '/') || '/';

// =========================================================
// Load the search index (only when needed)
// =========================================================
async function loadSearchIndex() {
    try {
        const response = await fetch(`${BASE_PATH}search-index.json`);
        if (!response.ok) throw new Error(`Failed to load index: ${response.status}`);
        const data = await response.json();
        searchDocuments = data;
        searchIndex = createLunrIndex(data);
    } catch (err) {
        console.error('Error loading search index:', err);
    }
}

// =========================================================
// Create the Lunr index
// =========================================================
function createLunrIndex(data) {
    return lunr(function () {
        this.ref('id');
        this.field('title');
        this.field('description');
        this.field('body');
        this.field('tags');
        data.forEach(doc => this.add(doc), this);
    });
}

// =========================================================
// Query handling helpers
// =========================================================
function getQueryFromURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get('q')?.trim() || '';
}

function updateQueryText(query) {
    document.querySelectorAll('.search-text').forEach(el => {
        el.textContent = query;
    });
}

// =========================================================
// Render search results (used on /search page only)
// =========================================================
function renderResults(query) {
    if (!searchIndex || !query) return;

    const results = searchIndex.search(query);
    const resultsContainer = document.getElementById('search-results');
    const template = document.getElementById('search-result-template');

    updateQueryText(query);

    // Redirect to no-results page if nothing found
    if (!results || results.length === 0) {
        const url = new URL(`${BASE_PATH}search/no-results`, window.location.origin);
        url.searchParams.set('q', query);
        window.location.href = url.toString(); // use href, not replace
        return;
    }

    // Render matching results
    if (!resultsContainer || !template) return;
    resultsContainer.innerHTML = '';

    const templateContent = template.content;
    results.forEach(result => {
        const doc = searchDocuments.find(d => d.id === result.ref);
        if (!doc) return;
        const item = createResultItem(doc, templateContent);
        resultsContainer.appendChild(item);
    });
}

// =========================================================
// Create individual result items
// =========================================================
function createResultItem(doc, templateContent) {
    const clone = templateContent.cloneNode(true);
    const item = clone.querySelector('.search-result-item');

    // --- Title ---
    const titleEl = item.querySelector('.result-title');
    if (titleEl) {
        const link = document.createElement('a');
        link.href = doc.id;
        link.target = '_self';
        link.className = 'link-plain text-reset';
        link.innerHTML = highlight(doc.title || doc.id, getQueryFromURL());
        titleEl.textContent = '';
        titleEl.appendChild(link);
    }

    // --- Description ---
    const descEl = item.querySelector('.result-description');
    if (descEl && doc.description) {
        descEl.innerHTML = highlight(doc.description, getQueryFromURL());
    }

    // --- Date ---
    const dateEl = item.querySelector('.result-date');
    if (dateEl && doc.date) {
        // Optionally format date
        const date = new Date(doc.date);
        dateEl.textContent = isNaN(date) ? doc.date : date.toLocaleDateString();
    }

    // --- Tags ---
    const tagsEl = item.querySelector('.result-tags');
    if (tagsEl && doc.tags) {
        if (Array.isArray(doc.tags)) {
            tagsEl.textContent = doc.tags.join(', ');
        } else {
            tagsEl.textContent = doc.tags;
        }
    }

    return item;
}

// =========================================================
// Initialization logic
// =========================================================
document.addEventListener('DOMContentLoaded', async () => {
    const path = window.location.pathname;
    const query = getQueryFromURL();
    updateQueryText(query);

    // Only load index if we're on a search page
    if (path.startsWith(`${BASE_PATH}search`)) {
        await loadSearchIndex();

        // Skip rendering for the explicit "no results" page
        if (!path.startsWith(`${BASE_PATH}search/no-results`) && query) {
            renderResults(query);
        }
    }
});

// =========================================================
// Handle search form submissions
// =========================================================
async function handleSearchRedirect(event) {
    event.preventDefault();

    const form = event.currentTarget.closest('form');
    const queryInput = form?.querySelector('.search-input');
    if (!queryInput) return;

    const query = queryInput.value.trim();
    if (!query) return;

    // Load index (can cache globally)
    if (!searchIndex) await loadSearchIndex();

    // Search immediately
    const results = searchIndex.search(query);

    // Pick destination
    const path = results.length > 0
        ? `${BASE_PATH}search`
        : `${BASE_PATH}search/no-results`;
    const url = new URL(path, window.location.origin);
    url.searchParams.set('q', query);

    // Navigate once
    window.location.href = url.toString();
}

// =========================================================
// Search term highlighting
// =========================================================

function highlight(text, query) {
    if (!text || !query) return text;
    const escaped = query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const regex = new RegExp(`(${escaped})`, 'gi');
    return text.replace(regex, '<mark>$1</mark>');
}

// --- Enable all forms on the page ---
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.search-form').forEach(form => {
        form.addEventListener('submit', handleSearchRedirect);
        form.querySelector('.search-button')?.addEventListener('click', handleSearchRedirect);
    });
});
