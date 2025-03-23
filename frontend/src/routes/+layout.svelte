<script lang="ts">
  import "../app.css";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";

  let { children } = $props();
</script>

<main class="min-h-screen flex flex-col bg-white">
  <Navbar />

  <main class="flex-grow">
    {@render children()}
  </main>

  <Footer />
</main>
