<script lang="ts">
  import ApartmentHero from "$lib/components/ApartmentHero.svelte";
  import ApartmentInfo from "$lib/components/ApartmentInfo.svelte";

  import type { PageData } from "./$types";

  let { data }: { data: PageData } = $props();
  const { apartment } = data;
</script>

<div class="bg-grey px-2.5">
  <div class="container mx-auto">
    <ApartmentHero {apartment} />
  </div>
</div>
<div class="container mx-auto px-2.5">
  <ApartmentInfo {apartment} />
</div>
