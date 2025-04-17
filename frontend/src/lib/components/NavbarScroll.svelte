<script lang="ts">
  import { onMount } from "svelte";
  import { page } from "$app/state";
  import { goto } from "$app/navigation";
  import Logo from "$lib/icons/Logo.svelte";
  import { Menu } from "@lucide/svelte";

  let isScrolled = false;
  let isMobileMenuOpen = false;

  let showNav = true;

  const scrollThresholdActivate = 50; // Scroll down past this to activate "scrolled" state
  const scrollThresholdDeactivate = 10; // Scroll up past this (i.e., below it) to deactivate

  onMount(() => {
    let lastScrollY = 0;

    const isMobile = () => window.innerWidth < 1024;
    const handleScroll = () => {
      const currentScrollY = window.scrollY;

      // Handle scrolled state (keep your original logic)
      if (currentScrollY > scrollThresholdActivate && !isScrolled) {
        isScrolled = true;
      } else if (currentScrollY < scrollThresholdDeactivate && isScrolled) {
        isScrolled = false;
      }

      // Handle nav visibility for mobile only
      if (isMobile()) {
        if (currentScrollY > lastScrollY && currentScrollY > 50) {
          // scrolling down
          showNav = false;
          if (isMobileMenuOpen) {
            isMobileMenuOpen = false; // ⬅ Close mobile menu on scroll down
          }
        } else {
          // scrolling up
          showNav = true;
        }
      } else {
        // Always show on desktop
        showNav = true;
      }

      lastScrollY = currentScrollY;
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  });

  async function handleNavigation(href: string, event: MouseEvent) {
    const [_, hash] = href.split("#");

    if (page.url.pathname === "/") {
      event.preventDefault();
      if (hash) {
        const section = document.getElementById(hash);
        if (section) {
          const navHeight = document.querySelector("nav")?.clientHeight || 0;
          const sectionTop = section.getBoundingClientRect().top + window.scrollY;
          window.scrollTo({
            top: sectionTop - navHeight,
            behavior: "smooth",
          });
          history.pushState({}, "", `/#${hash}`);
        }
      } else {
        window.scrollTo({ top: 0, behavior: "smooth" });
        history.pushState({}, "", "/");
      }
    } else {
      await goto(href, { noScroll: true });
      if (hash) {
        const section = document.getElementById(hash);
        if (section) {
          // Small timeout to ensure DOM is updated
          setTimeout(() => {
            const navHeight = document.querySelector("nav")?.clientHeight || 0;
            const sectionTop = section.getBoundingClientRect().top + window.scrollY;
            window.scrollTo({
              top: sectionTop - navHeight,
              behavior: "smooth",
            });
          }, 50);
        }
      } else {
        window.scrollTo({ top: 0, behavior: "smooth" });
      }
    }
  }

  const menuItems = [
    { href: "/#", label: "Strona Główna" },
    { href: "/#about", label: "O Nas" },
    { href: "/#apartments", label: "Apartamenty" },
    { href: "/#contact", label: "Kontakt" },
  ];
</script>

<nav
  class="bg-white text-gray-800 fixed w-full z-50 transition-all duration-300 transform lg:sticky lg:top-0
    {isScrolled ? 'shadow-md h-16' : 'h-24'}
    {showNav ? 'translate-y-0' : '-translate-y-full'}"
>
  <div class="container mx-auto grid grid-cols-[auto_1fr_auto] items-center h-full">
    <!-- Logo - Left Aligned -->
    <a href="/" class="flex items-center transition-all duration-300 gap-2 justify-self-start h-full">
      <div class={isScrolled ? "h-10 " : "h-14"}>
        <Logo class="h-full" />
      </div>
      <div class={`flex text-center fill-shrink-0 ${isScrolled ? "flex-row items-baseline gap-2" : "flex-col"}`}>
        <span class="font-ubuntu font-bold text-4xl"> TAPO </span>
        <span class="font-freestyle leading-[0.5] {isScrolled ? 'opacity-0 w-0' : 'text-4xl opacity-100 w-auto'}">
          apartamenty
        </span>
      </div>
    </a>

    <!-- Desktop Menu -->
    <ul class="hidden lg:flex space-x-4 justify-center items-center w-full">
      {#each menuItems as item}
        <li>
          <a
            href={item.href}
            on:click|preventDefault={(e) => handleNavigation(item.href, e)}
            class="hover:text-gray-600 transition-colors duration-300"
          >
            {item.label}
          </a>
        </li>
      {/each}
    </ul>

    <!-- Mobile Menu Button & Reservation Button Container -->
    <div class="flex items-center justify-end lg:justify-center gap-4">
      <!-- Reservation Button - Centered on mobile -->
      <a
        href="/reservation"
        class="lg:hidden bg-black text-white px-6 py-2 rounded-full hover:bg-gray-800 transition-colors duration-300
        whitespace-nowrap mx-auto"
      >
        Zarezerwuj
      </a>

      <!-- Hamburger Menu -->
      <button
        class="lg:hidden p-2 focus:outline-none ml-1 transition-transform duration-300 transform
    {isMobileMenuOpen ? 'rotate-90' : 'rotate-0'}"
        on:click={() => (isMobileMenuOpen = !isMobileMenuOpen)}
      >
        <Menu class="w-8 h-8" />
      </button>

      <!-- Desktop Reservation Button -->
      <a
        href="/reservation"
        class="hidden lg:block bg-black text-white px-6 py-2 rounded-full hover:bg-gray-800 transition-colors duration-300 justify-self-end whitespace-nowrap"
      >
        Zarezerwuj
      </a>
    </div>

    <!-- Mobile Menu Dropdown -->
    {#if isMobileMenuOpen}
      <div class="lg:hidden fixed top-full left-0 w-full bg-white shadow-md py-4">
        <ul class="flex flex-col items-center space-y-4">
          {#each menuItems as item}
            <li>
              <a
                href={item.href}
                on:click|preventDefault={(e) => {
                  handleNavigation(item.href, e);
                  isMobileMenuOpen = false;
                }}
                class="hover:text-gray-600 transition-colors duration-300"
              >
                {item.label}
              </a>
            </li>
          {/each}
        </ul>
      </div>
    {/if}
  </div>
</nav>

<style>
  .transition-all {
    transition-property: all;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-duration: 300ms;
  }
</style>
