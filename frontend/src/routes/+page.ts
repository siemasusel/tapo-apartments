import { apartments } from './apartments/data';
import type { PageLoad } from './$types';
import { contactInformation } from './data';

export const load: PageLoad = () => {
  return { apartments, contactInformation };
};
