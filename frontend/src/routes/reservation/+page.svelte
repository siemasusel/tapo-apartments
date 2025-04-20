<script lang="ts">
  import Reservation from "$lib/components/Reservation.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation } = data;
</script>

<main class="container text-center mx-auto py-12">
  <Reservation {contactInformation} />
</main>
