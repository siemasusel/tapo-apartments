<script lang="ts">
  import { Instagram } from "@lucide/svelte";
  import type { ContactInformation } from "$lib/types";

  export let contactInformation: ContactInformation;
</script>

<footer class="px-2.5 bg-gray-800 text-gray-300 py-6 mt-6">
  <div class="container mx-auto">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 lg:gap-6 text-center lg:text-left">
      <!-- Contact Info -->
      <div class="mb-2 lg:mb-0">
        <h3 class="text-gray-400 font-medium mb-2 lg:mb-3">Kontakt</h3>
        <p class="mb-1.5">
          <a href="tel:{contactInformation.phone}" class="hover:text-gray-100 transition-colors">
            {contactInformation.phone}
          </a>
        </p>
        <p class="mb-1.5">
          <a href="mailto:{contactInformation.email}" class="hover:text-gray-100 transition-colors">
            {contactInformation.email}
          </a>
        </p>
        <p class="mb-1.5 text-gray-400">
          {contactInformation.address.street}, {contactInformation.address.zip}
          {contactInformation.address.city}
        </p>
      </div>

      <!-- Quick Links -->
      <div class="mb-2 lg:mb-0">
        <h3 class="text-gray-400 font-medium mb-2 lg:mb-3">Przydatne linki</h3>
        <ul class="space-y-1.5">
          <li><a href="/" class="hover:text-gray-100 transition-colors">Strona główna</a></li>
          <li><a href="/apartments" class="hover:text-gray-100 transition-colors">Apartamenty</a></li>
          <li><a href="/reservation" class="hover:text-gray-100 transition-colors">Rezerwacja</a></li>
          <li><a href="/privacy-policy" class="hover:text-gray-100 transition-colors">Polityka Prywatności</a></li>
        </ul>
      </div>

      <!-- Social & Legal -->
      <div>
        <h3 class="text-gray-400 font-medium mb-2 lg:mb-3">Obserwuj nas</h3>
        <div class="flex justify-center lg:justify-start space-x-3 mb-2">
          <a href="/#" class="hover:text-gray-100 transition-colors">
            <Instagram class="size-8" />
          </a>
        </div>
      </div>
    </div>

    <!-- Copyright & Legal -->
    <div class="pt-4 lg:pt-6 mt-4 lg:mt-6 border-t border-gray-700 text-center">
      <p class="text-gray-400">&copy; 2025 TAPO Apartmenty. Wszystkie prawa zastrzeżone.</p>
      <!-- <ul class="mt-3 flex justify-center space-x-4"> -->
      <!--   <li> -->
      <!--     <a href="/privacy" class="text-gray-400 hover:text-gray-100 transition-colors">Polityka prywatności</a> -->
      <!--   </li> -->
      <!--   <li><a href="/terms" class="text-gray-400 hover:text-gray-100 transition-colors">Regulamin</a></li> -->
      <!-- </ul> -->
    </div>
  </div>
</footer>
