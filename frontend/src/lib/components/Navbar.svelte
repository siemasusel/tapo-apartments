<script>
  import { onMount } from 'svelte';

  let isScrolled = false;

  // Handle scroll event
  onMount(() => {
    const handleScroll = () => {
      isScrolled = window.scrollY > 50;
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  });
</script>

<nav
  class="bg-white text-gray-800 sticky top-0 z-50 transition-all duration-300 {isScrolled ? 'py-3 h-16 shadow-md' : 'py-5 h-24'}"
>
  <div class="container mx-auto flex justify-between items-center h-full">
    <!-- Logo -->
    <a
      href="/"
      class="flex items-center transition-all duration-300 {isScrolled ? 'space-x-2' : 'flex-col space-y-1'}"
    >
      <span class="font-bold transition-all duration-300 {isScrolled ? 'text-2xl' : 'text-3xl'}">TAPO</span>
      <span class="transition-all duration-300 {isScrolled ? 'text-lg' : 'text-xl'}">apartamenty</span>
    </a>

    <!-- Menu -->
    <ul class="flex space-x-4 items-center">
      <li><a href="/" class="hover:text-blue-600">Strona Główna</a></li>
      <li><a href="/about" class="hover:text-blue-600">O Nas</a></li>
      <li><a href="/apartments" class="hover:text-blue-600">Apartamenty</a></li>
      <li><a href="/contact" class="hover:text-blue-600">Kontakt</a></li>
      <li>
        <a
          href="/reservation"
          class="bg-blue-100 text-blue-800 px-4 py-2 rounded-full hover:bg-blue-200 transition-colors duration-300"
        >
          Rezerwacja
        </a>
      </li>
    </ul>
  </div>
</nav>

<style>
  /* Smooth transition for the logo */
  .transition-all {
    transition-property: all;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-duration: 300ms;
  }
</style>