//
//  SearchVinylsAPICommunicatorMock.m
//  searchvinyls
//
//  Created by Daniel Vela on 15/03/16.
//  Copyright © 2016 veladan. All rights reserved.
//

#import "SearchVinylsAPICommunicatorMock.h"

static const NSString* kSearchResponseSTR = @"{\"items\": [{\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/01/25/30177600_gal.jpg\", \"title\": \"(C84) Queen A Kind Of Magic Cd Musica Rock\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures.todocoleccion.net/tc/2012/01/07/29944521_gal.jpg\", \"title\": \"(D55) Queen Live At Wembley Stadium 2 Dvd Set Musica Rock Nuevos\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/02/21/30599337_gal.jpg\", \"title\": \"(D21) Queen Queen On Fire Live At The Bowl 2 Discos Dvd Musica Rock\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/03/03/30743463_gal.jpg\", \"title\": \"(F-C399) Queen Ii Cd Musica Hard Rock Sinfonico\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/03/03/30743503_gal.jpg\", \"title\": \"(F-C400) Queen A Night At The Opera Ed. Coleccionista 30 Aniversario Cd + Dvd Digipack Musica Rock\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/03/05/30778071_gal.jpg\", \"title\": \"(F-T5783) Queen The Game Cd Musica Hard Rock\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures.todocoleccion.net/tc/2012/01/09/29962349_gal.jpg\", \"title\": \"(T7963) Queen Jacky Gunn Y Jim Jenkins Coleccion Rock Pop Ediciones Catedra 1997 \"}, {\"price\": null, \"link\": null, \"image\": \"http://cloud1.todocoleccion.net/tc/2012/03/22/30993189_gal.jpg\", \"title\": \"(T-C333) Divine - Shoot Your Shot Uk 15 Tracks Cd Very Rare Drag Queen Music\"}, {\"price\": null, \"link\": null, \"image\": \"http://pictures4.todocoleccion.net/tc/2012/02/07/30369290_gal.jpg\", \"title\": \"(T3098) Queen Made In Heaven Cd Musica Rock\"}, {\"price\": null, \"link\": null, \"image\": \"http://www.todocoleccion.net/images/imagen_no_disponible.gif\", \"title\": \"(T3145) Concerts For The People Of Kampuchea 2 Lp The Clash The Who Queen Paul Mccartney Vinilo Rock\"}], \"total\": 1045, \"pages\": 105}";

static const NSString* kMostWantedResponseStr = @"{\"items\": [{\"item\": \"Los Planetas\"}, {\"item\": \"Nirvana\"}, {\"item\": \"Bj\u00f6rk\"}, {\"item\": \"Lita Claver\"}, {\"item\": \"Triangulo De Amor Bizarro\"}]}";

@interface SearchVinylsAPICommunicator ()

- (NSArray*)parseResponse:(NSData*)data onError:(ErrorBlock)errorBlock;

@end

@implementation SearchVinylsAPICommunicatorMock

-(void)searchFor:(NSString*)query onSuccess:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    NSData* data = [kSearchResponseSTR dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [super parseResponse:data onError:errorBlock];
    if (compBlock) compBlock(array);
}

-(void)getMostWanted:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    NSData* data = [kMostWantedResponseStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [super parseResponse:data onError:errorBlock];
    if (compBlock) compBlock(array);
}

@end
