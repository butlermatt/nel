part of nel.server;

@Route('/signin')
class NelSignin extends Vane {
  var pipeline = [Log, This];

  @Route('', method: 'POST')
  Future signIn() {
    log.info('Login request for: ${json['name']}');

    mongodb.then((db) {
      var usrCol = db.collection('users');

      usrCol.findOne(where.eq('name', json['name'])
                    .and(where.eq('password', json['password'])))
        .then((nelUser) {
        if(nelUser == null) {
          return close({'error' : 'Invalid username or password'});
        } else {
          var objId = nelUser.remove('_id');
          nelUser['objId'] = objId;
          return close(nelUser);
        }
      });

    });

    return end;
  }

  @Route('', method: 'GET')
  Future error() {
    log.warning('Somone tried to browse to signin link');
    write('That was bad!');
    return close('That was bad!');
  }

  @Route('/new', method: 'POST')
  Future signUp() {
    log.info('Received signUp request for ${json['name']}');

    mongodb.then((db) {
      var usrCol = db.collection('users');

      usrCol.findOne(where.eq('name', json['name'])
                    .or(where.eq('email', json['email'])))
        .then((res) {

          if(res != null) {
            var error =  {};
            if(res['name'] == json['name']) {
              error['error'] = 'A user already exists with that name';
            } else {
              error['error'] = 'A user has already signed up with that email account';
            }
            return close(error);
          } else {
            // No user returned. Now we can insert.
            var map = json as Map;
            map.remove('objId');
            usrCol.insert(map);
            usrCol.findOne(where.eq('name', map['name'])).then((usr) {
              usr.remove('password');
              log.info('Added user: $usr');
              return close(usr);
            });
          }
      });
    });

    return end;
  }
}