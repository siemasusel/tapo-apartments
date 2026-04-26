<script lang="ts">
  import { ArrowRight } from "@lucide/svelte";

  let {
    status,
    message,
  }: {
    status: number;
    message: string;
  } = $props();
</script>

<div class="flex flex-col items-center justify-center text-gray-800 font-sans p-4">
  <div class="text-center">
    <h1 class="text-8xl font-bold text-gray-800 mb-4">
      {status}
    </h1>
    <p class="text-lg md:text-xl text-gray-600 mb-8">{message}</p>
    <a
      href="/"
      class="inline-flex items-center px-6 py-3 rounded-full border border-transparent text-base font-medium
      text-white bg-primary hover:bg-primary-dark transition-colors duration-200"
    >
      Wróć do Strony Głównej
      <ArrowRight class="ml-1 size-5" />
    </a>
  </div>
</div>
