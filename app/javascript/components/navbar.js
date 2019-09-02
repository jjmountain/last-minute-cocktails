const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-filled');
      } else {
        navbar.classList.remove('navbar-filled');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };