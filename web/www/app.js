'use strict';

import {
    Server
} from 'http';
import express from 'express';
import socketIo from 'socket.io';
import expressConfiguration from './config/express';


let app = express()
const httpServer = new Server(app)
expressConfiguration(app)


export default httpServer;