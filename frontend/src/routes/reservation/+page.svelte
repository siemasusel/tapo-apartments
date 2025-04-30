<script lang="ts">
  import Reservation from "$lib/components/Reservation.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation } = data;
</script>

<div class="container px-2.5 text-center mx-auto py-12">
  <Reservation {contactInformation} />
</div>
