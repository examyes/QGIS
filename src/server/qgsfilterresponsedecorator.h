/***************************************************************************
                          qgsfilterresponsedecorator.h

  Define response adapter for handling filter's hooks
  -------------------
  begin                : 2017-01-05
  copyright            : (C) 2017 by David Marteau
  email                : david dot marteau at 3liz dot com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
#ifndef QGSFILTERRESPONSEDECORATOR_H
#define QGSFILTERRESPONSEDECORATOR_H

#include "qgsserverresponse.h"
#include "qgsserverfilter.h"

/**
 * \ingroup server
 * \class QgsFilterResponseDecorator
 * Class defining decorator for calling filter's hooks
 */
class QgsFilterResponseDecorator: public QgsServerResponse
{
  public:

    QgsFilterResponseDecorator( QgsServerFiltersMap filters, QgsServerResponse &response );
    ~QgsFilterResponseDecorator();

    /**
     * Call filters requestReady() method
     */
    void start();

    // QgsServerResponse overrides

    void setHeader( const QString &key, const QString &value ) override {  mResponse.setHeader( key, value ); }

    void removeHeader( const QString &key ) override { mResponse.removeHeader( key ); }

    QString header( const QString &key ) const override { return mResponse.header( key ); }

    QMap<QString, QString> headers() const override { return mResponse.headers( ); }

    bool headersSent() const override { return mResponse.headersSent(); }

    void setStatusCode( int code ) override { mResponse.setStatusCode( code ); }

    int statusCode( ) const override { return mResponse.statusCode( ); }

    void sendError( int code,  const QString &message ) override { mResponse.sendError( code, message ); }

    QIODevice *io() override { return mResponse.io(); }

    void finish() override;

    void flush() override;

    void clear() override { mResponse.clear(); }

    QByteArray data() const override { return mResponse.data(); }

    void truncate() override { mResponse.truncate(); }

  private:
    QgsServerFiltersMap  mFilters;
    QgsServerResponse   &mResponse;
};

#endif





