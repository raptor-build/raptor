/* -------------------------------------------------------------------------- */
/* TABLES                                                                     */
/* -------------------------------------------------------------------------- */

function raptorFilterTable(searchText, tableId) {
    const input = searchText.toLowerCase();
    const tbody = document.getElementById(tableId)?.querySelector('tbody');
    if (!tbody) return;

    if (!tbody.raptorFilterOriginalRows) {
        tbody.raptorFilterOriginalRows = Array.from(tbody.rows);
    }

    tbody.innerHTML = '';
    tbody.raptorFilterOriginalRows
    .filter(row => row.textContent.toLowerCase().includes(input))
    .forEach(row => tbody.appendChild(row));
}
