# wireguard setup

## generate keys

    wg_path=/etc/wireguard/
    
    server_privatekey=$wg_path/server.priv
    server_publickey=$wg_path/server.pub
    
    bmPixel_pub=$wg_path/bmPixel.public
    bmPixel_priv=$wg_path/bmPixel.private
    
    bmTP_pub=$wg_path/bmTP.public
    bmTP_priv=$wg_path/bmTP.private
    
    bmMoto_pub=$wg_path/bmMoto.public
    bmMoto_priv=$wg_path/bmMoto.private
    
    wg genkey > "$server_privatekey"
    
    wg pubkey < "$server_privatekey" > server_publickey_client1

    wg genkey | tee client1_privatekey | wg pubkey > client1_publickey
    wg genkey | tee client2_privatekey | wg pubkey > client2_publickeyo
