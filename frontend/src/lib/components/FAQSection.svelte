<script lang="ts">
  import { ChevronDown } from "@lucide/svelte";
  import { Accordion } from "bits-ui";

  interface FAQItem {
    id: string;
    question: string;
    answer: string;
    bulletpoints?: string[];
  }

  export const faqData: FAQItem[] = [
    {
      id: "1",
      question: "W jakich godzinach możliwe jest zameldowanie?",
      answer: "Zameldowanie dostępne jest od godziny 14:00.",
    },
    {
      id: "2",
      question: "O której godzinie jest wymeldowanie?",
      answer: "Z apartamentu należy się wymeldować do godziny 11:00.",
    },
    {
      id: "3",
      question: "Jak przebiega zakwaterowanie?",
      answer: "Proces zakwaterowania jest w pełni automatyczny:",
      bulletpoints: ["Brak konieczności kontaktu z obsługą.", "Szczegóły dostępu wysyłane mailowo po rezerwacji."],
    },
    // {
    //   id: "4",
    //   question: "Czy na miejscu jest parking?",
    //   answer: "Bezpłatny parking prywatny dostępny na miejscu",
    //   bulletpoints: ["Miejsca parkingowe bez rezerwacji", "Monitoring terenu", "Dostosowany do większych samochodów"],
    // },
    {
      id: "4",
      question: "Jak jest wyposażona kuchnia?",
      answer: "Pełne wyposażenie kuchenne zawiera:",
      bulletpoints: [
        "Sprzęt AGD: lodówka, mikrofalówka, czajnik, ekspres do kawy na kapsułki.",
        "Naczynia: garnki, patelnie, sztućce.",
        "Akcesoria: noże kuchenne, deski do krojenia, otwieracze.",
        "Szkło: kubki, szklanki, kieliszki.",
      ],
    },
    {
      id: "5",
      question: "Czy w apartamentach są ręczniki?",
      answer: "Tak, dostarczamy ręczniki dla wszystkich gości.",
    },
    // {
    //   id: "7",
    //   question: "Na jakich zasadach można korzystać z Wi-Fi?",
    //   answer: "Szybki internet Wi-Fi jest dostępny w całym obiekcie i jest bezpłatny",
    // },
    {
      id: "6",
      question: "Czy mogę przyjechać ze zwierzęciem?",
      answer: "W trosce o komfort wszystkich gości, pobyt ze zwierzętami nie jest możliwy.",
    },
    // {
    //   id: "7",
    //   question: "Czy można organizować imprezy?",
    //   answer: "Organizacja imprez jest w obiekcie zabroniona",
    // },
    {
      id: "7",
      question: "Czy można palić papierosy?",
      answer: "Palenie w apartamentach i balkonach jest całkowicie zabronione.",
      bulletpoints: [
        "Zakaz dotyczy wszystkich rodzajów papierosów, w tym e-papierosów i inhalatorów.",
        "Strefa dla osób palących znajduje się za parkingiem w rogu budynku.",
      ],
    },
  ];
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
