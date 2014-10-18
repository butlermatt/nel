part of nel.server;

@Route('/signin')
class NelSignin extends Vane {
  var pipeline = [Log, This];

  @Route('', method: 'POST')
  Future signIn() {
    log.info('Received Data: $json');
    var data = new Map<String, String>();
    data['success'] = 'Yes!';
    return close(data);
  }

  @Route('', method: 'GET')
  Future error() {
    log.warning('Somone tried to browse to signin link');
    write('That was bad!');
    return close('That was bad!');
  }
}