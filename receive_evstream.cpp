#include <mdsobjects.h>
#include <unistd.h>
class MyListener: public MDSplus::DataStreamListener
{
    const char *channelName;
public:
  MyListener(const char *channelName)
    {
        this->channelName = channelName;
    }
    void dataReceived(MDSplus::Data *samples, MDSplus::Data *times, int shot)
    {
          std::cout << "Channel: " << channelName << "   Time: " << times << "  Value: " << samples << std::endl;
    }
};

int main(int argc, char *argv[])
{
    MDSplus::EventStream evStream;
    
    for(int i = 0; i < argc - 1; i++)
	evStream.registerListener(new MyListener(argv[i+1]), argv[i+1]);
    evStream.start();
    sleep(10000);
    return 0;
};
