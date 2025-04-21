import type { PageLoad } from './$types';
import { contactInformation } from './data';

export const prerender = true;

export const load: PageLoad = () => {
  return { contactInformation };
};
