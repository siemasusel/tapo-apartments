<script lang="ts">
  import { Mail, Phone, MapPinHouse } from "lucide-svelte";
  import type { ContactInformation } from "$lib/types";

  export let contactInformation: ContactInformation;
</script>

<div class="container mx-auto py-16">
  <div class="flex flex-col lg:flex-row gap-8 rounded-xl overflow-hidden">
    <!-- Left Side - Google Map -->
    <div class="w-full lg:w-1/2 h-96">
      <iframe
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2595.979520354412!2d20.951532976637672!3d49.409292971412135!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x473e763c9cf2bd33%3A0xcb614eddf6d56865!2sJ.%20I.%20Kraszewskiego%2074%2C%2033-380%20Krynica-Zdr%C3%B3j!5e0!3m2!1sen!2spl!4v1741714115799!5m2!1sen!2spl"
        title="Apartment location"
        width="100%"
        height="100%"
        style="border:0;"
        allowfullscreen
        loading="lazy"
        referrerpolicy="no-referrer-when-downgrade"
        class="rounded-lg"
      ></iframe>
    </div>

    <!-- Right Side - Contact Information -->
    <div class="w-full lg:w-1/2 bg-primary p-8 rounded-xl flex flex-col justify-center">
      <h2 class="text-3xl font-bold text-white mb-6">Skontaktuj się z nami</h2>

      <!-- Address -->
      <div class="flex items-start mb-6">
        <div class="bg-primary-dark p-3 rounded-lg mr-4">
          <MapPinHouse class="text-white h-6 w-6" />
        </div>
        <div>
          <h3 class="text-lg font-semibold text-white mb-1">Nasza lokalizacja</h3>
          <p class="text-white">
            {contactInformation.address.street}, {contactInformation.address.zip}
            {contactInformation.address.city}
          </p>
        </div>
      </div>

      <!-- Email -->
      <div class="flex items-start mb-6">
        <div class="bg-primary-dark p-3 rounded-lg mr-4">
          <Mail class="text-white h-6 w-6" />
        </div>
        <div>
          <h3 class="text-lg font-semibold text-white mb-1">Email</h3>
          <a href="mailto:{contactInformation.email}" class="text-white hover:underline">{contactInformation.email}</a>
        </div>
      </div>

      <!-- Phone -->
      <div class="flex items-start">
        <div class="bg-primary-dark p-3 rounded-lg mr-4">
          <Phone class="text-white h-6 w-6" />
        </div>
        <div>
          <h3 class="text-lg font-semibold text-white mb-1">Telefon</h3>
          <a href="tel:{contactInformation.phone}" class="text-white hover:underline">{contactInformation.phone}</a>
        </div>
      </div>
    </div>
  </div>
</div>
