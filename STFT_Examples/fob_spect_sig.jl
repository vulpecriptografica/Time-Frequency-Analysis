using Plots
using FFTW
using STFT
using WAV
using DSP


#Loading audio
channels, sampling_rate = wavread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/My Songs Know.wav", format = "double") #signal encoded with double precision
sig = channels[:, 1] #channels is an NxC matrix where N = #length of audio samples, C = # of channels (C=1 for our purposes)
println("sampling freq: $sampling_rate Hz\n duration: $(round(length(sig) / sampling_rate, digits=2)) s")
println("number of samples:", length(sig))


t = range(0, length(sig) / sampling_rate, length=length(sig)) 
plot(t, sig, size = (1000, 300), xlabel = "Time (s)",ylabel = "Amplitude", legend = false, xlims=(0,17), margin=6mm)
savefig("my_songs_graph.png")