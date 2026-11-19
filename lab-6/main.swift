
import SwiftUI
import Foundation

struct Post: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError
    case decodingFailed
}

class PostService {

    func fetchPosts() async throws -> [Post] {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw APIError.invalidURL
        }

        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError
        }

        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
        } catch {
            throw APIError.decodingFailed
        }
    }
}

@MainActor
class PostViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage = ""

    private let service = PostService()

    func fetchPosts() async {

        isLoading = true
        errorMessage = ""
        posts = []

        do {
            let result = try await service.fetchPosts()
            posts = result
        } catch APIError.invalidURL {
            errorMessage = "Invalid URL"
        } catch APIError.invalidResponse {
            errorMessage = "Invalid server response"
        } catch APIError.httpError {
            errorMessage = "Server error occurred"
        } catch APIError.decodingFailed {
            errorMessage = "Unable to decode data"
        } catch {
            errorMessage = "Network error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

struct ContentView: View {

    @StateObject private var viewModel = PostViewModel()

    var body: some View {
        NavigationStack {
            VStack {

                if viewModel.isLoading {
                    ProgressView("Loading Posts...")
                        .padding()
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()

                    Button("Retry") {
                        Task {
                            await viewModel.fetchPosts()
                        }
                    }
                    .buttonStyle(.borderedProminent)

                } else if viewModel.posts.isEmpty {
                    Text("No posts found")
                        .foregroundColor(.secondary)
                        .padding()

                    Button("Retry") {
                        Task {
                            await viewModel.fetchPosts()
                        }
                    }
                    .buttonStyle(.borderedProminent)

                } else {
                    List(viewModel.posts) { post in
                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(post.title)
                                    .font(.headline)

                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Post Directory")
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}

struct PostDetailView: View {

    var post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text(post.title)
                .font(.title2)
                .bold()

            Text(post.body)
                .font(.body)

            Text("Post ID: \(post.id)")
                .foregroundColor(.secondary)

            Text("User ID: \(post.userId)")
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        .navigationTitle("Post Details")
    }
}

#Preview {
    ContentView()
}