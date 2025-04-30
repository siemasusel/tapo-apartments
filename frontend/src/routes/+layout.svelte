<script lang="ts">
  import "../app.css";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import type { LayoutProps } from "./$types";

  let { data, children }: LayoutProps = $props();
  let { contactInformation } = data;
</script>

<div class="min-h-screen flex flex-col bg-white font-primary">
  <Navbar />
  <main class="flex-grow">
    {@render children()}
  </main>

  <Footer {contactInformation} />
</div>
