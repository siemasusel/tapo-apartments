import type { PageLoad } from './$types';
import { contactInformation } from './data';

// This can be false if you're using a fallback (i.e. SPA mode)
export const prerender = true;

export const load: PageLoad = () => {
  return { contactInformation };
};
