'use strict';

import React from 'react';
import { render } from 'react-dom';
import { Provider as StoreProvider } from 'react-redux';
import { IntlProvider, addLocaleData, defineMessages } from 'react-intl';
import enLocaleData from 'react-intl/locale-data/en';
import deLocaleData from 'react-intl/locale-data/de';