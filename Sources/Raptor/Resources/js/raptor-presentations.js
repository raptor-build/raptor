/* -------------------------------------------------------------------------- */
/* MODAL & POPOVER                                                */
/* -------------------------------------------------------------------------- */

const openModal = id => document.getElementById(id)?.showModal();
const closeModal = id => document.getElementById(id)?.close();
const openPopover = id => document.getElementById(id)?.showPopover();
const closePopover = id => document.getElementById(id)?.hidePopover();
