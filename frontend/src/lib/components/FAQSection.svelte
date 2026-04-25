<script lang="ts">
  import { ChevronDown } from "@lucide/svelte";
  import { Accordion } from "bits-ui";
  import { faqData } from "$lib/data/faq";
</script>

<Accordion.Root class="w-full" type="single">
  {#each faqData as item}
    <Accordion.Item value={item.id} class="mb-2 rounded-md border border-gray-200">
      <Accordion.Header class="bg-gray-50 transition-colors hover:bg-gray-100 rounded-t-md">
        <Accordion.Trigger
          class="group flex w-full items-center justify-between p-4 text-left font-medium rounded-t-md"
        >
          <span>{item.question}</span>
          <ChevronDown
            class="size-5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-[state=open]:rotate-180"
          />
        </Accordion.Trigger>
      </Accordion.Header>
      <Accordion.Content class="overflow-hidden rounded-b-md">
        <div class="p-4 text-gray-800">
          <p>{item.answer}</p>
          {#if item.bulletpoints}
            <ul class="list-disc mt-3 pl-6 space-y-2">
              {#each item.bulletpoints as point}
                <li>{point}</li>
              {/each}
            </ul>
          {/if}
        </div>
      </Accordion.Content>
    </Accordion.Item>
  {/each}
</Accordion.Root>

<style>
  @keyframes accordionOpen {
    from {
      height: 0px;
    }
    to {
      height: var(--bits-accordion-content-height);
    }
  }

  @keyframes accordionClose {
    from {
      height: var(--bits-accordion-content-height);
    }
    to {
      height: 0px;
    }
  }

  :global([data-accordion-content][data-state="open"]) {
    animation: accordionOpen 0.2s ease-out;
  }

  :global([data-accordion-content][data-state="closed"]) {
    animation: accordionClose 0.2s ease-out;
  }
</style>
