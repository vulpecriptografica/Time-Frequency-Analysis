#Goal: Apply a lowpass filter (in this case, a Butterworth filter of order 16) to data, then graph time domain reps. of original signal and filtered signal

using Plots
using FFTW
using DSP

#Given a dt (time step) and total recording time, returns an array of times that a signal would be sampled at.

function sampling_func(T,dt)
    
    sample_times=Float64[] #initialize empty array
    n=0 #counter

    while n*dt ≤ T
        
        append!(sample_times, [n*dt]) 
        n += 1
 
    end #ends while loop
    
    return sample_times
    
        
end

T = 50
dt = 0.005 #time step (= 1\f_s)

sampling_func(T,dt)


#Generating a signal: Create a function that, given three arrays of the same length each containing values of amplitude A, angular frequency \omega, and phase \phi, along with an array of time steps t from part A, returns a discrete array of a sum of sinusoids with the specified parameters. It should take the form A sin(\omega t + \phi) for each input sinusoid.
#N.B.: Enter normal frequencies, not angular frequencies. The 2pi in newbie converts the frequency to angular frequency.

function newsignal(array_1, array_2, array_3, times)
    
    #Sinusoid format: A sin( 2 pi * \omega t + \phi)
    
    function sinusoid_array(array, times)
        
        holder = Float64[]
        
        for t in times
            newbie = [array[1]*sin(array[2]*2*pi*t+array[3])] #angular frequency info encoded in here
            append!(holder, newbie)
        
        end
        
    return holder
        
        
    end
    
    net_sinusoid = sinusoid_array(array_1, times) + sinusoid_array(array_2, times) + sinusoid_array(array_3, times)
    

    return net_sinusoid
    

end


array_1 = [1,2,-1]
array_2 = [4,7,0]
array_3 = [10,12,0]

fs = 1/dt

#Filtering in time
filtermethod = Butterworth(16) #creating Butterworth filter of order 16
filter = digitalfilter(Lowpass(6, fs=fs), filtermethod) #creating lowpass filter, removes freqs above 6, w/ given sampling freq

x = sampling_func(T,dt) #times the signal is sampled at
y = newsignal(array_1, array_2, array_3, x) #original signal

timeSignal = filtfilt(filter, y) #this is the time signal with the filter applied in the time domain
#filters twice, essentially, to remove phase distortion

#Plotting signals in time domain
p1 = plot(x,y, title = "Original Signal", xlabel = "Time (s)", ylabel = "Amplitude", legend=false)
p2 = plot(x, timeSignal, title = "Lowpass Filtered Signal" , xlabel = "Time (s)", ylabel = "Amplitude", legend=false)
plot(p1, p2, layout = (2,1), xlims = (0,10))
savefig("filtering_ex_time.png")


