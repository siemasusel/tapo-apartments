<script lang="ts">
  import { onMount } from "svelte";
  import { page } from "$app/state";
  import { goto } from "$app/navigation";
  import Logo from "$lib/icons/Logo.svelte";

  let isScrolled = false;

  const scrollThresholdActivate = 50; // Scroll down past this to activate "scrolled" state
  const scrollThresholdDeactivate = 10; // Scroll up past this (i.e., below it) to deactivate

  onMount(() => {
    const handleScroll = () => {
      // Only apply scroll behavior for large screens
      if (window.innerWidth < 1024) return;

      const currentScrollY = window.scrollY;

      if (currentScrollY > scrollThresholdActivate) {
        if (!isScrolled) isScrolled = true;
      } else if (currentScrollY < scrollThresholdDeactivate) {
        if (isScrolled) isScrolled = false;
      }
    };

    const handleResize = () => {
      if (window.innerWidth < 1024 && isScrolled) {
        isScrolled = false;
      }
    };

    window.addEventListener("scroll", handleScroll);
    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("scroll", handleScroll);
      window.removeEventListener("resize", handleResize);
    };
  });

  async function handleNavigation(href: string, event: MouseEvent) {
    const [_, hash] = href.split("#");

    const isDesktop = window.innerWidth >= 1024;

    if (page.url.pathname === "/") {
      event.preventDefault();
      if (hash) {
        const section = document.getElementById(hash);
        if (section) {
          const navHeight = isDesktop ? document.querySelector("nav")?.clientHeight || 0 : 0;

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
        // Wait until DOM updates
        setTimeout(() => {
          const section = document.getElementById(hash);
          const navHeight = isDesktop ? document.querySelector("nav")?.clientHeight || 0 : 0;

          if (section) {
            const sectionTop = section.getBoundingClientRect().top + window.scrollY;

            window.scrollTo({
              top: sectionTop - navHeight,
              behavior: "smooth",
            });
          } else {
            console.warn("Section not found:", hash);
          }
        }, 100);
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

  let isOpen = false;
</script>

<nav
  class="bg-white text-gray-800 relative lg:sticky lg:top-0 z-50 transition-all duration-300 {isScrolled
    ? 'h-16 shadow-md'
    : 'h-24'}"
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

      <button
        class="lg:hidden p-2 focus:outline-none ml-1"
        on:click={() => (isOpen = !isOpen)}
        aria-label="Menu toggle"
      >
        <svg
          class="w-8 h-8 text-black"
          viewBox="0 0 24 24"
          stroke="currentColor"
          fill="none"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <!-- Top Line -->
          <line
            x1="4"
            y1="6"
            x2="20"
            y2="6"
            class="transition-all duration-300 origin-center"
            style={`transform: ${isOpen ? "rotate(45deg) translateY(6px)" : "rotate(0deg) translateY(0px)"};`}
          />
          <!-- Middle Line -->
          <line
            x1="4"
            y1="12"
            x2="20"
            y2="12"
            class="transition-all duration-300 origin-center"
            style={`opacity: ${isOpen ? 0 : 1}; transform: scaleX(${isOpen ? 0 : 1});`}
          />
          <!-- Bottom Line -->
          <line
            x1="4"
            y1="18"
            x2="20"
            y2="18"
            class="transition-all duration-300 origin-center"
            style={`transform: ${isOpen ? "rotate(-45deg) translateY(-6px)" : "rotate(0deg) translateY(0px)"};`}
          />
        </svg>
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
    {#if isOpen}
      <div class="lg:hidden absolute top-full left-0 w-full bg-white shadow-md py-4">
        <ul class="flex flex-col items-center space-y-4">
          {#each menuItems as item}
            <li>
              <a
                href={item.href}
                on:click|preventDefault={(e) => {
                  handleNavigation(item.href, e);
                  isOpen = false;
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
