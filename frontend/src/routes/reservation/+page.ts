import type { PageLoad } from './$types';
import { contactInformation } from '../data';

export const load: PageLoad = () => {
  return { contactInformation };
};
