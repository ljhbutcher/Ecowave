class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question })
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  # def perform(*args)
  #   # Do something later
  # end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    results << { role: "system", content: "You are an assistant for a website that aims to inform fashion industry experts on the environmental impact of the materials they use." }
    questions.each do |question|
      results << { role: "user", content: question.user_question + "only responds if a greeting such as 'Hello' or if this is related to the fashion industry otherwise respond with 'I'm sorry, I can only answer questions related to the fashion industry. Please try again.'"}
      results << { role: "assistant", content: question.ai_answer || "If there is an answer, format the final answer using bullet points (each bullet point on new line) but no symbols, or headings" }
    end
    return results
  end

end
