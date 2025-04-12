<script lang="ts">
  import ApartmentHero from "$lib/components/ApartmentHero.svelte";
  import ApartmentInfo from "$lib/components/ApartmentInfo.svelte";

  import type { PageData } from "./$types";

  let { data }: { data: PageData } = $props();
  const { apartment } = data;
</script>

<div class="bg-grey">
  <main class="container mx-auto">
    <ApartmentHero {apartment} />
  </main>
</div>
<main class="container mx-auto">
  <ApartmentInfo {apartment} />
</main>
