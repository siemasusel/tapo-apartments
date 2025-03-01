<script>
    export let titleClass = "text-3xl lg:text-4xl";
</script>

<div class="space-y-8">
    <h2 class="{titleClass} font-bold text-gray-900 mb-6">Rezerwacja</h2>

    <div class="space-y-6">
        <div class="space-y-4">
            <div class="flex flex-col items-center md:items-start">
                <span class="text-lg font-semibold text-gray-700">Telefon</span>
                <a
                    href="tel:+48543345435"
                    class="text-xl text-blue-600 hover:text-blue-700"
                >
                    +48 543 345 435
                </a>
            </div>

            <div class="flex items-center text-gray-400">
                <div class="flex-1 border-t border-gray-200"></div>
                <span class="px-4">lub</span>
                <div class="flex-1 border-t border-gray-200"></div>
            </div>

            <div class="flex flex-col items-center md:items-start">
                <span class="text-lg font-semibold text-gray-700">E-mail</span>
                <a
                    href="mailto:rezerwacje@tapoapartamenty.pl"
                    class="text-xl text-blue-600 hover:text-blue-700"
                >
                    rezerwacje@tapoapartamenty.pl
                </a>
            </div>
        </div>

        <div class="pt-6 border-t border-gray-100">
            <h3 class="text-lg font-medium text-gray-600 mb-4">
                Wymagane informacje:
            </h3>
            <ul class="space-y-3 text-gray-600">
                <li class="flex items-start space-x-2">
                    <svg
                        class="w-5 h-5 text-green-500 flex-shrink-0"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M5 13l4 4L19 7"
                        />
                    </svg>
                    <span>Nazwę wybranego apartamentu</span>
                </li>
                <li class="flex items-start space-x-2">
                    <svg
                        class="w-5 h-5 text-green-500 flex-shrink-0"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M5 13l4 4L19 7"
                        />
                    </svg>
                    <span>Planowaną liczbę gości</span>
                </li>
                <li class="flex items-start space-x-2">
                    <svg
                        class="w-5 h-5 text-green-500 flex-shrink-0"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M5 13l4 4L19 7"
                        />
                    </svg>
                    <span>Zakres dat pobytu</span>
                </li>
                <li class="flex items-start space-x-2">
                    <svg
                        class="w-5 h-5 text-green-500 flex-shrink-0"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M5 13l4 4L19 7"
                        />
                    </svg>
                    <span>Numer telefonu kontaktowego</span>
                </li>
            </ul>
        </div>
    </div>
</div>
