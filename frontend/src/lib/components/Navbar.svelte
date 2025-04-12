<script>
  import { onMount } from "svelte";

  let isScrolled = false;

  // Define separate thresholds
  const scrollThresholdActivate = 60; // Scroll down past this to activate "scrolled" state
  const scrollThresholdDeactivate = 20; // Scroll up past this (i.e., below it) to deactivate

  onMount(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;

      // Logic with Hysteresis
      if (currentScrollY > scrollThresholdActivate) {
        // Only update if state needs changing
        if (!isScrolled) {
          isScrolled = true;
        }
      } else if (currentScrollY < scrollThresholdDeactivate) {
        // Only update if state needs changing
        if (isScrolled) {
          isScrolled = false;
        }
      }
      // **Implicitly:** If scrollY is between thresholdDeactivate and thresholdActivate,
      // isScrolled retains its current value, preventing the flicker.
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  });
</script>

<nav
  class="bg-white text-gray-800 sticky top-0 z-50 transition-all duration-300 {isScrolled
    ? 'py-3 h-16 shadow-md'
    : 'py-5 h-26'}"
>
  <div class="container mx-auto grid grid-cols-3 items-center h-full">
    <!-- Logo - Left Aligned -->
    <a
      href="/"
      class="flex items-center transition-all duration-300 {isScrolled ? 'space-x-2' : 'flex-col'} justify-self-start"
    >
      <span class="font-ubuntu font-bold transition-all duration-300 {isScrolled ? 'text-3xl' : 'text-4xl'}">TAPO</span>
      <span class="font-freestyle transition-all duration-300 {isScrolled ? 'text-3xl' : 'text-4xl'}">apartamenty</span>
    </a>

    <!-- Centered Menu -->
    <ul class="flex space-x-4 justify-center items-center">
      <li><a href="/" class="hover:text-gray-600 transition-colors duration-300">Strona Główna</a></li>
      <li><a href="/" class="hover:text-gray-600 transition-colors duration-300">O Nas</a></li>
      <li><a href="/apartments" class="hover:text-gray-600 transition-colors duration-300">Apartamenty</a></li>
      <li><a href="/" class="hover:text-gray-600 transition-colors duration-300">Kontakt</a></li>
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
