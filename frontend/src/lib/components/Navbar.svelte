<script>
  import { onMount } from 'svelte';

  let isScrolled = false;

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
  <div class="container mx-auto px-4 grid grid-cols-3 items-center h-full">
    <!-- Logo - Left Aligned -->
    <a
      href="/"
      class="flex items-center transition-all duration-300 {isScrolled ? 'space-x-2' : 'flex-col space-y-1'} justify-self-start"
    >
      <span class="font-bold transition-all duration-300 {isScrolled ? 'text-2xl' : 'text-3xl'}">TAPO</span>
      <span class="transition-all duration-300 {isScrolled ? 'text-lg' : 'text-xl'}">apartamenty</span>
    </a>

    <!-- Centered Menu -->
    <ul class="flex space-x-4 justify-center items-center">
      <li><a href="/" class="hover:text-gray-600 transition-colors duration-300">Strona Główna</a></li>
      <li><a href="/about" class="hover:text-gray-600 transition-colors duration-300">O Nas</a></li>
      <li><a href="/apartments" class="hover:text-gray-600 transition-colors duration-300">Apartamenty</a></li>
      <li><a href="/contact" class="hover:text-gray-600 transition-colors duration-300">Kontakt</a></li>
    </ul>

    <!-- Simplified Reservation Button -->
    <a
      href="/reservation"
      class="bg-black text-white px-6 py-2 rounded-full hover:bg-gray-800 transition-colors duration-300 justify-self-end"
    >
      Zarezerwuj
    </a>
  </div>
</nav>

<style>
  .transition-all {
    transition-property: all;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-duration: 300ms;
  }
</style>