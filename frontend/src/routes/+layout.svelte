<script lang="ts">
  import "../app.css";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import type { LayoutProps } from "./$types";

  let { data, children }: LayoutProps = $props();
  let { contactInformation } = data;
</script>

<main class="min-h-screen flex flex-col bg-white">
  <Navbar />
  <!-- <main class="flex-grow mt-[6.5rem] lg:mt-0"> -->
  <main class="flex-grow">
    {@render children()}
  </main>

  <Footer {contactInformation} />
</main>
