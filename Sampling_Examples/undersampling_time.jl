using Plots
using FFTW

#Goal: Graph input sinusoid


#Given a dt (time step) and total recording time, returns an array of times that a signal would be sampled at

function sampling_func(T,dt)
    
    sample_times=Float64[] #initialize empty array
    n=0 #counter

    while n*dt ≤ T
        append!(sample_times, [n*dt]) 
        n += 1
    end 
    return sample_times
        
end

T = 60
dt = 0.07 #15 Hz
#Calling the fxn
sampling_func(T,dt)


#Given three arrays of the same length each containing values of amplitude A, angular frequency \omega, and phase \phi, along with an array of time steps t from part A, returns a discrete array of a sum of sinusoids with the specified parameters. I
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


#Calling fxn
times = sampling_func(T,dt)
newsignal(array_1, array_2, array_3, times)


#Plots a signal over time

function signal_plot(x,y)
    
    plot(x,y, title="Plot of Samples", linewidth=1, linecolor="magenta", label="Linear interpolation")
    xlabel!("Time (s)")
    ylabel!("Amplitude")
    xlims!(0,3)
    scatter!(x, y, label="Data", mc=:blue)
    
end

x = sampling_func(T,dt)
y = newsignal(array_1, array_2, array_3, x)

signal_plot(x,y)
savefig("undersampling_time.png")
