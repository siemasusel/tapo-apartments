export interface FAQItem {
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
  {
    id: "6",
    question: "Czy mogę przyjechać ze zwierzęciem?",
    answer: "W trosce o komfort wszystkich gości, pobyt ze zwierzętami nie jest możliwy.",
  },
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
