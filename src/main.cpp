

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#ifdef _WIN32
    #include <io.h>
#elif __linux__
    #include <inttypes.h>
    #include <unistd.h>
    #define __int64 int64_t
    #define _close close
    #define _read read
    #define _lseek64 lseek64
    #define _O_RDONLY O_RDONLY
    #define _open open
    #define _lseeki64 lseek64
    #define _lseek lseek
    #define stricmp strcasecmp
#endif
#include <unistd.h>

#include "fm_radio.h"
#include "audio.h"

using namespace std;

int main(int argc, char **argv)
{
    static unsigned char IQ[SAMPLES*4];
    static int left_audio[AUDIO_SAMPLES];
    static int right_audio[AUDIO_SAMPLES];

    if ( argc < 2 )
    {
        printf("Missing input file.\n");
        return -1;
    }
    /*
    // initialize the audio output
    int audio_fd = audio_init( AUDIO_RATE );
    if ( audio_fd < 0 )
    {
        printf("Failed to initialize audio!\n");
        return -1;
    }
    */
    int audio_fd = open("audio_dump.bin", O_WRONLY);

    FILE * usrp_file = fopen(argv[1], "rb");
    if ( usrp_file == NULL )
    {
        printf("Unable to open file.\n");
        return -1;
    }    
    
    // run the FM receiver 
    while( !feof(usrp_file) )
    {
        // get I/Q from data file
        fread( IQ, sizeof(char), SAMPLES*4, usrp_file );

        // fm radio in mono
        fm_radio_stereo( IQ, left_audio, right_audio );

        // write to audio output
        audio_tx( audio_fd, AUDIO_RATE, left_audio, right_audio, AUDIO_SAMPLES );
    }

    fclose( usrp_file );
    close( audio_fd );

    return 0;
}

